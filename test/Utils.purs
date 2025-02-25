module Test.Ctl.Utils
  ( ValidationM(ValidationM)
  , aesonRoundTrip
  , assertTrue
  , assertTrue_
  , errEither
  , errMaybe
  , measure
  , measure'
  , measureWithTimeout
  , readAeson
  , runValidationM
  , toFromAesonTest
  , toFromAesonTestWith
  ) where

import Prelude

import Aeson
  ( class DecodeAeson
  , class EncodeAeson
  , Aeson
  , JsonDecodeError
  , decodeAeson
  , encodeAeson
  , parseJsonStringToAeson
  )
import Control.Alt (class Alt)
import Control.Alternative (class Alternative)
import Control.Monad.Error.Class
  ( class MonadError
  , class MonadThrow
  , throwError
  )
import Control.Monad.Except.Trans (ExceptT, runExceptT)
import Control.MonadPlus (class MonadPlus)
import Control.MonadZero (class MonadZero)
import Control.Plus (class Plus)
import Ctl.Internal.Test.TestPlanM (TestPlanM)
import Data.DateTime.Instant (unInstant)
import Data.Either (Either(Left, Right), either)
import Data.Identity (Identity(Identity))
import Data.Maybe (Maybe(Just, Nothing), maybe)
import Data.Medea (ValidationError(EmptyError))
import Data.Newtype (unwrap, wrap)
import Data.Time.Duration (class Duration, Milliseconds, Seconds)
import Data.Time.Duration (fromDuration, toDuration) as Duration
import Effect.Aff (Aff, error)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console (log)
import Effect.Exception (throw, throwException)
import Effect.Now (now)
import Mote (test)
import Node.Encoding (Encoding(UTF8))
import Node.FS.Sync (readTextFile)
import Node.Path (FilePath)
import Test.Spec.Assertions (shouldEqual)

-- this silly thing is needed because Medea's `validate` needs both
-- MonadPlus and MonadError, there must be a better way
-- or it should be upstreamed to medea-ps as a default
newtype ValidationM a = ValidationM (ExceptT ValidationError Identity a)

derive newtype instance functorValidationM :: Functor ValidationM
derive newtype instance applyValidationM :: Apply ValidationM
derive newtype instance applicativeValidationM :: Applicative ValidationM
derive newtype instance bindValidationM :: Bind ValidationM
derive newtype instance monadValidationM :: Monad ValidationM
derive newtype instance monadThrowValidationM ::
  MonadThrow ValidationError ValidationM

derive newtype instance monadErrorValidationM ::
  MonadError ValidationError ValidationM

-- note: MonadZero is being deprecated
derive newtype instance monadZeroValidationM :: MonadZero ValidationM
derive newtype instance monadPlusValidationM :: MonadPlus ValidationM
instance altValidationM :: Alt ValidationM where
  alt (ValidationM first) (ValidationM second) = case runExceptT first of
    (Identity (Right a)) -> pure a
    (Identity (Left _)) -> case runExceptT second of
      (Identity (Right a)) -> pure a
      (Identity (Left e)) -> throwError e

instance plusValidationM :: Plus ValidationM where
  empty = throwError EmptyError

instance alternativeValidationM :: Alternative ValidationM

runValidationM :: forall (a :: Type). ValidationM a -> Either ValidationError a
runValidationM (ValidationM etvia) = do
  let (Identity eva) = runExceptT etvia
  eva

measure :: forall (m :: Type -> Type) (a :: Type). MonadEffect m => m a -> m a
measure = measure' (Nothing :: Maybe Seconds)

measureWithTimeout
  :: forall (m :: Type -> Type) (d :: Type) (a :: Type)
   . MonadEffect m
  => Duration d
  => d
  -> m a
  -> m a
measureWithTimeout timeout = measure' (Just timeout)

measure'
  :: forall (m :: Type -> Type) (d :: Type) (a :: Type)
   . MonadEffect m
  => Duration d
  => Maybe d
  -> m a
  -> m a
measure' timeout action =
  getNowMs >>= \startTime -> action >>= \result -> getNowMs >>= \endTime ->
    liftEffect do
      let
        duration :: Milliseconds
        duration = wrap (endTime - startTime)

        durationSeconds :: Seconds
        durationSeconds = Duration.toDuration duration

      case timeout of
        Just timeout' | duration > Duration.fromDuration timeout' -> do
          let msg = "Timeout exceeded, execution time: " <> show durationSeconds
          throwException (error msg)
        _ ->
          log ("---\nExecution time: " <> show durationSeconds)
      pure result
  where
  getNowMs :: m Number
  getNowMs = unwrap <<< unInstant <$> liftEffect now

-- | Test a boolean value, throwing the provided string as an error if `false`
assertTrue
  :: forall (m :: Type -> Type)
   . Applicative m
  => MonadEffect m
  => String
  -> Boolean
  -> m Unit
assertTrue msg b = unless b $ liftEffect $ throwException $ error msg

assertTrue_
  :: forall (m :: Type -> Type)
   . Applicative m
  => MonadEffect m
  => Boolean
  -> m Unit
assertTrue_ = assertTrue "Boolean test failed"

errEither
  :: forall (m :: Type -> Type) (a :: Type) (e :: Type)
   . MonadEffect m
  => Show e
  => Either e a
  -> m a
errEither = either (liftEffect <<< throw <<< show) pure

errMaybe
  :: forall (m :: Type -> Type) (a :: Type)
   . MonadEffect m
  => String
  -> Maybe a
  -> m a
errMaybe msg = maybe (liftEffect $ throw msg) pure

toFromAesonTest
  :: forall (a :: Type)
   . Eq a
  => DecodeAeson a
  => EncodeAeson a
  => Show a
  => String
  -> a
  -> TestPlanM (Aff Unit) Unit
toFromAesonTest desc x = test desc $ aesonRoundTrip x `shouldEqual` Right x

toFromAesonTestWith
  :: forall (a :: Type)
   . Eq a
  => DecodeAeson a
  => EncodeAeson a
  => Show a
  => String
  -> (a -> a)
  -> a
  -> TestPlanM (Aff Unit) Unit
toFromAesonTestWith desc transform x =
  test desc $ aesonRoundTripWith transform x `shouldEqual` Right x

aesonRoundTripWith
  :: forall (a :: Type)
   . Eq a
  => Show a
  => DecodeAeson a
  => EncodeAeson a
  => (a -> a)
  -> a
  -> Either JsonDecodeError a
aesonRoundTripWith transform = decodeAeson <<< encodeAeson <<< transform

aesonRoundTrip
  :: forall (a :: Type)
   . Eq a
  => Show a
  => DecodeAeson a
  => EncodeAeson a
  => a
  -> Either JsonDecodeError a
aesonRoundTrip = aesonRoundTripWith identity

readAeson :: forall (m :: Type -> Type). MonadEffect m => FilePath -> m Aeson
readAeson = errEither <<< parseJsonStringToAeson
  <=< liftEffect <<< readTextFile UTF8
