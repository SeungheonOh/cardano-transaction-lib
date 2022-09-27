module Contract.Test.E2E.Feedback.Node
  ( getBrowserEvents
  , subscribeToBrowserEvents
  ) where

import Prelude

import Aeson (decodeAeson, parseJsonStringToAeson)
import Contract.Test.E2E.Feedback (BrowserEvent(Failure, Success))
import Data.Array (all)
import Data.Either (Either(Left), hush, note)
import Data.Maybe (Maybe(Just, Nothing), fromMaybe)
import Data.Newtype (unwrap, wrap)
import Data.Number (infinity)
import Data.Time.Duration (Seconds(Seconds))
import Data.Traversable (for, traverse_)
import Effect (Effect)
import Effect.Aff
  ( Aff
  , Canceler(Canceler)
  , Milliseconds(Milliseconds)
  , delay
  , forkAff
  , killFiber
  , launchAff_
  , makeAff
  , try
  )
import Effect.Class (liftEffect)
import Effect.Exception (error, throw)
import Effect.Ref as Ref
import Foreign (unsafeFromForeign)
import Helpers (liftEither)
import Toppokki as Toppokki

-- | React to events raised by the browser
subscribeToBrowserEvents
  :: Maybe Seconds
  -> Toppokki.Page
  -> (BrowserEvent -> Effect Unit)
  -> Aff Unit
subscribeToBrowserEvents timeout page cont = do
  makeAff \f -> do
    timeoutFiber <- Ref.new Nothing
    processFiber <- Ref.new Nothing
    launchAff_ do
      liftEffect <<< flip Ref.write timeoutFiber <<< Just =<< forkAff do
        delay $ wrap $ 1000.0 * unwrap (fromMaybe (Seconds infinity) timeout)
        liftEffect $ f $ Left $ error "Timeout reached"
      liftEffect <<< flip Ref.write processFiber <<< Just =<< forkAff do
        try process >>= liftEffect <<< f
    pure $ Canceler \e -> do
      liftEffect (Ref.read timeoutFiber) >>= traverse_ (killFiber e)
      liftEffect (Ref.read timeoutFiber) >>= traverse_ (killFiber e)
  where
  process :: Aff Unit
  process = do
    events <- getBrowserEvents page
    continue <- for events \event -> do
      void $ liftEffect $ try $ cont event
      case event of
        Success -> pure false
        Failure err -> liftEffect $ throw err
        _ -> pure true
    if all identity continue then do
      delay $ Milliseconds $ 1000.0
      process
    else pure unit

getBrowserEvents
  :: Toppokki.Page -> Aff (Array BrowserEvent)
getBrowserEvents page = do
  frgn <- Toppokki.unsafeEvaluateStringFunction collectEventsJS page
  let
    (encodedEvents :: Array String) = unsafeFromForeign frgn
  -- liftEffect $ Console.log $ "getBrowserEvenrs: " <> show encodedEvents
  for encodedEvents \event -> do
    liftEither $ note (error $ "Unable to decode BrowserEvent from: " <> event)
      $ hush
      $ decodeAeson =<< parseJsonStringToAeson event

collectEventsJS :: String
collectEventsJS =
  """
  (() => {
    const res = window.ctlE2ECommunications || [];
    window.ctlE2ECommunications = [];
    return res;
  })()
  """
