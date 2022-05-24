-- | This module demonstrates how the `Contract` interface can be used to build,
-- | balance, and submit a transaction. It creates a simple transaction that gets
-- | UTxOs from the user's wallet and sends two Ada back to the same wallet address
module Examples.Pkh2Pkh (main) where

import Contract.Prelude

import Contract.Address (NetworkId(TestnetId), ownPaymentPubKeyHash)
import Contract.Monad
  ( ConfigParams(ConfigParams)
  , LogLevel(Trace)
  , defaultDatumCacheWsConfig
  , defaultOgmiosWsConfig
  , defaultServerConfig
  , defaultSlotConfig
  , launchAff_
  , liftedE
  , liftedM
  , logInfo'
  , mkContractConfig
  , runContract_
  )
import Contract.ScriptLookups as Lookups
import Contract.Transaction
  ( BalancedSignedTransaction(BalancedSignedTransaction)
  , balanceAndSignTx
  , submit
  )
import Contract.TxConstraints as Constraints
import Contract.Value as Value
--import Contract.Wallet (mkNamiWalletAff)
import Serialization.Address (addressFromBech32)
import Serialization (privateKeyFromBytes)
import Types.ByteArray (hexToByteArray)
import Wallet (mkKeyWallet)
import Data.BigInt as BigInt

main :: Effect Unit
main = launchAff_ $ do
  -- wallet <- Just <$> mkNamiWalletAff
  priv <- liftEffect $ map join $ traverse privateKeyFromBytes $ hexToByteArray "8f093aa4103fb26121148fd2ece4dd1d775be9113dfa374bcb4817b36356180b"
  let pub = addressFromBech32 "addr_test1vrh5y2r5f8mhhjtjvl02y7um25kgwcsl7wfaeu7h53erhcg0uzan9"
      wallet = mkKeyWallet <$> pub <*> priv
  cfg <- mkContractConfig $ ConfigParams
    { ogmiosConfig: defaultOgmiosWsConfig
    , datumCacheConfig: defaultDatumCacheWsConfig
    , ctlServerConfig: defaultServerConfig
    , networkId: TestnetId
    , slotConfig: defaultSlotConfig
    , logLevel: Trace
    , extraConfig: {}
    , wallet
    }

  runContract_ cfg $ do
    logInfo' "Running Examples.Pkh2Pkh"
    pkh <- liftedM "Failed to get own PKH" ownPaymentPubKeyHash

    let
      constraints :: Constraints.TxConstraints Void Void
      constraints = Constraints.mustPayToPubKey pkh
        $ Value.lovelaceValueOf
        $ BigInt.fromInt 5 -- 2_000_000

      lookups :: Lookups.ScriptLookups Void
      lookups = mempty

    ubTx <- liftedE $ Lookups.mkUnbalancedTx lookups constraints
    BalancedSignedTransaction bsTx <-
      liftedM "Failed to balance/sign tx" $ balanceAndSignTx ubTx
    txId <- submit bsTx.signedTxCbor
    logInfo' $ "Tx ID: " <> show txId
