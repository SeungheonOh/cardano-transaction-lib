{- | This module is intended to be used for running custom E2E-tests -}
module Contract.Test.E2E.Helpers
  ( E2EOutput
  , RunningExample
  , ExtensionId(ExtensionId)
  , WalletPassword(WalletPassword)
  , checkSuccess
  , delaySec
  , eternlConfirmAccess
  , eternlSign
  , geroConfirmAccess
  , geroSign
  , flintConfirmAccess
  , flintSign
  , lodeConfirmAccess
  , lodeSign
  , namiConfirmAccess
  , namiSign
  , withExample
  ) where

import Prelude

import Contract.Test.E2E.Feedback (testFeedbackIsTrue)
import Control.Alternative ((<|>))
import Control.Promise (Promise, toAffE)
import Data.Array (any, elem, head)
import Data.Either (fromRight, hush)
import Data.Foldable (intercalate)
import Data.Maybe (Maybe(Just, Nothing), isJust)
import Data.Newtype (class Newtype, wrap, unwrap)
import Data.String.CodeUnits as String
import Data.String.Pattern (Pattern(Pattern))
import Data.Traversable (for, fold)
import Effect (Effect)
import Effect.Aff (Aff, bracket, delay, launchAff_, try)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Effect.Exception (error, throw)
import Effect.Ref (Ref)
import Effect.Ref as Ref
import Effect.Uncurried (mkEffectFn1, EffectFn1)
import Foreign (Foreign, unsafeFromForeign)
import Helpers (liftedM)
import Toppokki as Toppokki

data OutputType = PageError | Console | RequestFailed

derive instance Eq OutputType

newtype E2EOutput = E2EOutput
  { outputType :: OutputType
  , output :: String
  }

type RunningExample =
  { browser :: Toppokki.Browser
  , jQuery :: String
  , main :: Toppokki.Page
  , errors :: Ref (Array E2EOutput)
  }

newtype WalletPassword = WalletPassword String

derive instance Newtype WalletPassword _

-- | Download jQuery
retrieveJQuery :: Toppokki.Page -> Aff String
retrieveJQuery = toAffE <<< _retrieveJQuery

-- | Simulate physical typing into a form element.
typeInto :: Selector -> String -> Toppokki.Page -> Aff Unit
typeInto selector text page = toAffE $ _typeInto selector text page

-- | Find the popup page of the wallet. This works for both Nami and Gero
-- | by looking for a page with a button. If there is a button on the main page
-- | this needs to be modified.
findWalletPage :: Pattern -> Toppokki.Browser -> Aff (Maybe Toppokki.Page)
findWalletPage pattern browser = do
  pages <- Toppokki.pages browser
  head <<< fold <$> for pages \page -> do
    eiPageUrl <- map hush $ try $ pageUrl page
    pure $
      case eiPageUrl of
        Nothing -> []
        Just url
          | String.contains pattern url -> [ page ]
          | otherwise -> []

pageUrl :: Toppokki.Page -> Aff String
pageUrl page = do
  unsafeFromForeign <$> Toppokki.unsafeEvaluateStringFunction
    "document.location.href"
    page

-- | Wait until the wallet page pops up. Timout should be at least a few seconds.
-- | The 'String' param is the text of jQuery, which will be injected.
waitForWalletPage
  :: Pattern -> Number -> Toppokki.Browser -> Aff Toppokki.Page
waitForWalletPage pattern timeout browser =
  findWalletPage pattern browser >>= case _ of
    Nothing -> do
      if timeout > 0.0 then do
        delaySec 0.1
        waitForWalletPage pattern (timeout - 0.1) browser
      else liftEffect $ throw $
        "Wallet popup did not open. Did you provide extension ID correctly? "
          <> "Provided pattern: "
          <> unwrap pattern
    Just page -> pure page

waitForWalletPageClose
  :: Pattern -> Number -> Toppokki.Browser -> Aff Unit
waitForWalletPageClose pattern timeout browser =
  findWalletPage pattern browser >>= case _ of
    Nothing -> do
      pure unit
    Just _page -> do
      if timeout > 0.0 then do
        delaySec 0.1
        waitForWalletPageClose pattern (timeout - 0.1) browser
      else liftEffect $ throw $
        "Wallet popup did not close. Did you provide extension ID correctly? "
          <> "Provided pattern: "
          <> unwrap pattern

showOutput :: Ref (Array E2EOutput) -> Effect String
showOutput ref =
  Ref.read ref >>= map show' >>> intercalate "\n" >>> pure
  where
  show' :: E2EOutput -> String
  show' (E2EOutput { outputType, output }) = showType outputType <> " " <>
    output

  showType :: OutputType -> String
  showType PageError = "ERR"
  showType Console = "..."
  showType RequestFailed = "REQ"

-- | Navigate to an example's page, inject jQuery and set up error handlers
startExample :: Toppokki.URL -> Toppokki.Browser -> Aff RunningExample
startExample url browser = do
  page <- Toppokki.newPage browser
  jQuery <- retrieveJQuery page
  errorRef <- liftEffect $ Ref.new []
  liftEffect do
    Toppokki.onPageError (handler errorRef PageError $ pure <<< show) page
    Toppokki.onConsole (handler errorRef Console Toppokki.consoleMessageText)
      page
    Toppokki.onRequestFailed (handler errorRef RequestFailed $ pure <<< show)
      page
  Toppokki.goto url page
  pure
    { browser: browser
    , jQuery: jQuery
    , main: page
    , errors: errorRef
    }
  where

  -- Setup a handler for an output type.
  handler
    :: forall (a :: Type)
     . Ref (Array (E2EOutput))
    -> OutputType
    -> (a -> Aff String)
    -> EffectFn1 a Unit
  handler errorRef outputType f = mkEffectFn1 \e -> launchAff_ do
    output <- f e
    liftEffect $ Ref.modify_
      ( _ <>
          [ E2EOutput
              { outputType: outputType
              , output: output
              }
          ]
      )
      errorRef

-- | Run an example in the browser and close the browser afterwards
-- | A Wallet page will be detected.
-- | Sample usage:
-- |   withBrowser options NamiExt \browser -> do
-- |     withExample
-- |        (wrap "http://myserver:1234/docontract")
-- |        browser $ do
-- |          namiSign $ wrap "mypassword"
withExample
  :: forall (a :: Type)
   . Toppokki.URL
  -> Toppokki.Browser
  -> (RunningExample -> Aff a)
  -> Aff a
withExample url browser = bracket (startExample url browser)
  (const $ pure unit)

waitForTestFeedback :: RunningExample -> Number -> Aff Unit
waitForTestFeedback ex@{ main, errors } timeout
  | timeout <= 0.0 = pure unit
  | otherwise =
      do
        done <-
          testFeedbackIsTrue main <|>
            any isError <$> liftEffect (Ref.read errors)
        delaySec 1.0
        when (not done) $ waitForTestFeedback ex (timeout - 1.0)
      where
      isError :: E2EOutput -> Boolean
      isError (E2EOutput { outputType }) = outputType `elem`
        [ PageError, RequestFailed ]

checkSuccess :: RunningExample -> Aff Boolean
checkSuccess ex@{ main, errors } = do
  waitForTestFeedback ex 80.0
  feedback <- testFeedbackIsTrue main
  unless feedback $ liftEffect $ showOutput errors >>= log
  pure feedback

newtype ExtensionId = ExtensionId String

derive instance Newtype ExtensionId _

inWalletPage
  :: forall (a :: Type)
   . Pattern
  -> RunningExample
  -> Number
  -> (Toppokki.Page -> Aff a)
  -> Aff a
inWalletPage pattern { browser, jQuery } timeout cont = do
  page <- waitForWalletPage pattern timeout browser
  injectJQuery page jQuery
  cont page

-- | Provide an extension ID and a pattern to match.
-- | First, we wait for a popup with given extension ID.
-- | If the URL matches the pattern, the action is executed.
-- | Otherwise, `Nothing` is returned.
inWalletPageOptional
  :: forall (a :: Type)
   . ExtensionId
  -> Pattern
  -> RunningExample
  -> Number
  -> (Toppokki.Page -> Aff a)
  -> Aff (Maybe a)
inWalletPageOptional extId pattern { browser, jQuery } timeout cont = do
  try acquirePage <#> fromRight Nothing
  where
  acquirePage = do
    page <- waitForWalletPage (Pattern $ unwrap extId) timeout browser
    url <- liftedM (error "inWalletPageOptional: page closed")
      $ map hush
      $ try
      $ pageUrl page
    if
      String.contains pattern url then do
      injectJQuery page jQuery
      Just <$> cont page
    else do
      pure Nothing

eternlConfirmAccess :: ExtensionId -> RunningExample -> Aff Unit
eternlConfirmAccess extId re = do
  wasInPage <- isJust <$> inWalletPageOptional extId pattern re
    confirmAccessTimeout
    \page -> do
      delaySec 1.0
      void $ Toppokki.pageWaitForSelector (wrap "span.capitalize") {} page
      clickButton "Connect to Site" page
  when wasInPage do
    waitForWalletPageClose pattern 10.0 re.browser
  where
  pattern :: Pattern
  pattern = wrap $ unwrap extId <> "/www/index.html#/connect/"

eternlSign :: ExtensionId -> WalletPassword -> RunningExample -> Aff Unit
eternlSign extId wpassword re = do
  inWalletPage pattern re signTimeout \page -> do
    void $ Toppokki.pageWaitForSelector (wrap $ unwrap $ inputType "password")
      {}
      page
    -- TODO: why does it require a delay?
    delaySec 0.1
    typeInto (inputType "password") (unwrap wpassword) page
    void $ doJQ (wrap "span.capitalize:contains(\"sign\")") click page
  where
  pattern :: Pattern
  pattern = wrap $ unwrap extId <> "/www/index.html#/signtx"

namiConfirmAccess :: ExtensionId -> RunningExample -> Aff Unit
namiConfirmAccess extId re =
  inWalletPage (wrap $ unwrap extId) re confirmAccessTimeout
    (clickButton "Access")

namiSign :: ExtensionId -> WalletPassword -> RunningExample -> Aff Unit
namiSign extId wpassword re = do
  inWalletPage (wrap $ unwrap extId) re signTimeout \nami -> do
    clickButton "Sign" nami
    reactSetValue password (unwrap wpassword) nami
    clickButton "Confirm" nami

geroConfirmAccess :: ExtensionId -> RunningExample -> Aff Unit
geroConfirmAccess extId re = do
  inWalletPage (wrap $ unwrap extId) re confirmAccessTimeout \page -> do
    delaySec 0.1
    void $ doJQ (inputType "radio") click page
    void $ doJQ (buttonWithText "Continue") click page
    delaySec 0.1
    void $ doJQ (inputType "checkbox") click page
    void $ doJQ (buttonWithText "Connect") click page

geroSign :: ExtensionId -> WalletPassword -> RunningExample -> Aff Unit
geroSign extId gpassword re =
  inWalletPage (wrap $ unwrap extId) re signTimeout \gero -> do
    void $ doJQ (byId "confirm-swap") click gero
    typeInto (byId "wallet-password") (unwrap gpassword) gero
    clickButton "Next" gero

-- Not implemented yet
flintConfirmAccess :: ExtensionId -> RunningExample -> Aff Unit
flintConfirmAccess _ _ =
  liftEffect $ throw "Flint support is not implemented"

-- Not implemented yet
flintSign :: ExtensionId -> WalletPassword -> RunningExample -> Aff Unit
flintSign _ _ _ = do
  liftEffect $ throw "Flint support is not implemented"

lodeConfirmAccess :: ExtensionId -> RunningExample -> Aff Unit
lodeConfirmAccess extId re = do
  wasOnAccessPage <- inWalletPage pattern re confirmAccessTimeout \page -> do
    delaySec 0.1
    isOnAccessPage <- isJQuerySelectorAvailable (buttonWithText "Access") page
      re.jQuery
    when isOnAccessPage do
      void $ doJQ (buttonWithText "Access") click page
    pure isOnAccessPage
  when wasOnAccessPage do
    waitForWalletPageClose pattern 10.0 re.browser
  where
  pattern = Pattern $ unwrap extId

lodeSign :: ExtensionId -> WalletPassword -> RunningExample -> Aff Unit
lodeSign extId gpassword re = do
  inWalletPage (wrap $ unwrap extId) re signTimeout \page -> do
    void $ Toppokki.pageWaitForSelector (wrap $ unwrap $ inputType "password")
      {}
      page
    isOnSignPage <- isJQuerySelectorAvailable (buttonWithText "Approve") page
      re.jQuery
    unless isOnSignPage do
      liftEffect $ throw $ "lodeSign: unable to find signing page"
    typeInto (inputType "password") (unwrap gpassword) page
    delaySec 0.1
    clickButton "Approve" page

isJQuerySelectorAvailable :: Selector -> Toppokki.Page -> String -> Aff Boolean
isJQuerySelectorAvailable selector page jQuery = do
  injectJQuery page jQuery
  unsafeFromForeign <$> Toppokki.unsafeEvaluateStringFunction
    ("!!$('" <> unwrap selector <> "').length")
    page

confirmAccessTimeout :: Number
confirmAccessTimeout = 10.0

signTimeout :: Number
signTimeout = 50.0

-- | A String representing a jQuery selector, e.g. "#my-id" or ".my-class"
newtype Selector = Selector String

derive instance Newtype Selector _

-- | A String representing a jQuery action, e.g. "click" or "enable".
newtype Action = Action String

derive instance Newtype Action _

-- | Build a primitive jQuery expression like '$("button").click()' and
-- | out of a selector and action and evaluate it in Toppokki
doJQ :: Selector -> Action -> Toppokki.Page -> Aff Foreign
doJQ selector action page = do
  Toppokki.unsafeEvaluateStringFunction jq page
  where
  jq :: String
  jq = "$('" <> unwrap selector <> "')." <> unwrap action

-- | select a button with a specific text inside
buttonWithText :: String -> Selector
buttonWithText text = wrap $ "button:contains(" <> text <> ")"

-- | select an input element of a specific type
inputType :: String -> Selector
inputType typ = wrap $ "input[type=\"" <> typ <> "\"]"

-- | select an element by Id
byId :: String -> Selector
byId = wrap <<< ("#" <> _)

-- | select any password field
password :: Selector
password = wrap ":password"

click :: Action
click = wrap "click()"

clickButton :: String -> Toppokki.Page -> Aff Unit
clickButton buttonText = void <$> doJQ (buttonWithText buttonText) click

injectJQuery :: Toppokki.Page -> String -> Aff Unit
injectJQuery page jQuery = do
  (alreadyInjected :: Boolean) <- unsafeFromForeign <$>
    Toppokki.unsafeEvaluateStringFunction "typeof(jQuery) !== 'undefined'"
      page
  unless alreadyInjected $ void $ Toppokki.unsafeEvaluateStringFunction jQuery
    page

-- | Set the value of an item with the browser's native value setter.
-- | This is necessary for react items so that react reacts.
-- | (sometimes 'typeInto' is an alternative).
-- | React is used in Nami.
-- | https://stackoverflow.com/questions/23892547/what-is-the-best-way-to-trigger-onchange-event-in-react-js
reactSetValue :: Selector -> String -> Toppokki.Page -> Aff Unit
reactSetValue selector value page = void
  $ flip Toppokki.unsafeEvaluateStringFunction page
  $ fold
      [ "let input = $('" <> unwrap selector <> "').get(0);"
      , "var nativeInputValueSetter = "
          <>
            " Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;"
      , "nativeInputValueSetter.call(input, '" <> value <> "');"
      , "var ev2 = new Event('input', { bubbles: true});"
      , "input.dispatchEvent(ev2);"
      ]

foreign import _retrieveJQuery :: Toppokki.Page -> Effect (Promise String)

foreign import _typeInto
  :: Selector -> String -> Toppokki.Page -> Effect (Promise Unit)

delaySec :: Number -> Aff Unit
delaySec seconds = delay $ wrap $ seconds * 1000.0

{-
-- This can initialize gero and import a walllet without storing any config data
-- anywhere. However, there doesn't seem to be a straightforward way to set the collateral,
-- which makes it rather useless, as this would involve opening the extension popup window,
-- and that is currently not supported in Puppeteer.

geroInit :: Toppokki.Browser -> Aff Unit
geroInit browser = do
  page <- Toppokki.newPage browser
  jQuery <- retrieveJQuery page
  Toppokki.goto
    (wrap "chrome-extension://iifeegfcfhlhhnilhfoeihllenamcfgc/index.html")
    page
  void $ Toppokki.unsafeEvaluateStringFunction jQuery page
  delay $ wrap 1000.0
  void $ doJQ (buttonWithText "Get Started") click page
  delay $ wrap 1000.0
  void $ doJQ (wrap "a[href=\"#/wallet-options/import-wallet\"]") click page
  delay $ wrap 100.0
  reactSetValue (byId "wallet-name") "ctltest" page
  typeInto textarea geroSeed page
  void $ doJQ (buttonWithText "Import") click page
  delay $ wrap 100.0
  typeInto (byId "wallet-password") testPasswordGero page
  typeInto (byId "wallet-password-confirm") testPasswordGero page
  void $ doJQ (byId "user-agree") click page
  void $ doJQ (byId "password-agree") click page
  void $ doJQ (byId "set-up-password") click page
  delay $ wrap 100.0
  void $ doJQ (buttonWithText "Continue") click page
  delay $ wrap 100.0
  void $ doJQ (byId "done") click page
-}
