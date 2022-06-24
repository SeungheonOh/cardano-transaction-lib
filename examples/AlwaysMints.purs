-- | This module demonstrates how the `Contract` interface can be used to build,
-- | balance, and submit a smart-contract transaction. It creates a transaction
-- | that mints a value using the `AlwaysMints` policy
module Examples.AlwaysMints (main) where

import Contract.Prelude

import Contract.Aeson (decodeAeson, fromString)
import Contract.Monad
  ( launchAff_
  , liftContractAffM
  , liftContractM
  , liftedE
  , liftedM
  , logInfo'
  , runContract_
  , traceTestnetContractConfig
  )
import Contract.Prim.ByteArray (byteArrayFromAscii)
import Contract.ScriptLookups as Lookups
import Contract.Scripts (MintingPolicy)
import Contract.Transaction
  ( BalancedSignedTransaction(BalancedSignedTransaction)
  , balanceAndSignTx
  , submit
  )
import Contract.TxConstraints as Constraints
import Contract.Value as Value
import Data.BigInt as BigInt

main :: Effect Unit
main = launchAff_ $ do
  cfg <- traceTestnetContractConfig
  runContract_ cfg $ do
    logInfo' "Running Examples.AlwaysMints"
    mp <- liftContractM "Invalid script JSON" $ alwaysMintsPolicy
    cs <- liftContractAffM "Cannot get cs" $ Value.scriptCurrencySymbol mp
    tn <- liftContractM "Cannot make token name"
      $ Value.mkTokenName
      =<< byteArrayFromAscii "TheToken"

    let
      constraints :: Constraints.TxConstraints Void Void
      constraints = Constraints.mustMintValue
        $ Value.singleton cs tn
        $ BigInt.fromInt 100

      lookups :: Lookups.ScriptLookups Void
      lookups = Lookups.mintingPolicy mp

    ubTx <- liftedE $ Lookups.mkUnbalancedTx lookups constraints
    BalancedSignedTransaction bsTx <-
      liftedM "Failed to balance/sign tx" $ balanceAndSignTx ubTx
    txId <- submit bsTx.signedTxCbor
    logInfo' $ "Tx ID: " <> show txId

foreign import alwaysMintsCbor :: String

alwaysMintsPolicy :: Maybe MintingPolicy
alwaysMintsPolicy = map wrap $ hush $ decodeAeson $ fromString alwaysMintsCbor
