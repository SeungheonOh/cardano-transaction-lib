// This file was generated by purescript-docs-search
window.DocsSearchTypeIndex["2049046393"] = [{"values":[{"sourceSpan":{"start":[454,1],"name":"src/Types/TxConstraints.purs","end":[458,23]},"score":0,"packageInfo":{"values":[],"tag":"LocalPackage"},"name":"mustSpendScriptOutput","moduleName":"Types.TxConstraints","info":{"values":[{"type":{"tag":"ForAll","contents":["i",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ForAll","contents":["o",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Types","Transaction"],"TransactionInput"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Types","Redeemer"],"Redeemer"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Types","TxConstraints"],"TxConstraints"]},{"tag":"TypeVar","contents":"i"}]},{"tag":"TypeVar","contents":"o"}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":null}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[471,1],"name":"src/Types/TxConstraints.purs","end":[475,23]},"score":0,"packageInfo":{"values":[],"tag":"LocalPackage"},"name":"mustSpendNativeScriptOutput","moduleName":"Types.TxConstraints","info":{"values":[{"type":{"tag":"ForAll","contents":["i",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ForAll","contents":["o",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Types","Transaction"],"TransactionInput"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Cardano","Types","NativeScript"],"NativeScript"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Types","TxConstraints"],"TxConstraints"]},{"tag":"TypeVar","contents":"i"}]},{"tag":"TypeVar","contents":"o"}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":null}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[299,1],"name":"src/Types/TxConstraints.purs","end":[307,23]},"score":0,"packageInfo":{"values":[],"tag":"LocalPackage"},"name":"mustPayToPubKey","moduleName":"Types.TxConstraints","info":{"values":[{"type":{"tag":"ForAll","contents":["i",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ForAll","contents":["o",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ConstrainedType","contents":[{"constraintClass":[["Prim","TypeError"],"Warn"],"constraintArgs":[{"tag":"ParensInType","contents":{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim","TypeError"],"Text"]},{"tag":"TypeLevelString","contents":"Some wallets may not recognize addresses without a staking key component. Consider using mustPayToPubKeyAddress"}]}}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Types","PubKeyHash"],"PaymentPubKeyHash"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Plutus","Types","Value"],"Value"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Types","TxConstraints"],"TxConstraints"]},{"tag":"TypeVar","contents":"i"}]},{"tag":"TypeVar","contents":"o"}]}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":"Lock the value with a public key\n"}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[371,1],"name":"src/Types/TxConstraints.purs","end":[375,23]},"score":0,"packageInfo":{"values":[],"tag":"LocalPackage"},"name":"mustPayToNativeScript","moduleName":"Types.TxConstraints","info":{"values":[{"type":{"tag":"ForAll","contents":["i",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ForAll","contents":["o",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["NativeScripts"],"NativeScriptHash"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Plutus","Types","Value"],"Value"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Types","TxConstraints"],"TxConstraints"]},{"tag":"TypeVar","contents":"i"}]},{"tag":"TypeVar","contents":"o"}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":null}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[384,1],"name":"src/Types/TxConstraints.purs","end":[388,23]},"score":0,"packageInfo":{"values":[],"tag":"LocalPackage"},"name":"mustMintValueWithRedeemer","moduleName":"Types.TxConstraints","info":{"values":[{"type":{"tag":"ForAll","contents":["i",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ForAll","contents":["o",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Types","Redeemer"],"Redeemer"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Plutus","Types","Value"],"Value"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Types","TxConstraints"],"TxConstraints"]},{"tag":"TypeVar","contents":"i"}]},{"tag":"TypeVar","contents":"o"}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":"Mint the given `Value` by accessing non-Ada assets.\n"}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[479,1],"name":"src/Types/TxConstraints.purs","end":[480,76]},"score":0,"packageInfo":{"values":[],"tag":"LocalPackage"},"name":"mustHashDatum","moduleName":"Types.TxConstraints","info":{"values":[{"type":{"tag":"ForAll","contents":["i",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ForAll","contents":["o",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Types","Transaction"],"DataHash"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Types","Datum"],"Datum"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Types","TxConstraints"],"TxConstraints"]},{"tag":"TypeVar","contents":"i"}]},{"tag":"TypeVar","contents":"o"}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":null}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[29,1],"name":"src/Types/MultiMap.purs","end":[29,77]},"score":0,"packageInfo":{"values":[],"tag":"LocalPackage"},"name":"singleton","moduleName":"Types.MultiMap","info":{"values":[{"type":{"tag":"ForAll","contents":["k",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ForAll","contents":["v",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ConstrainedType","contents":[{"constraintClass":[["Data","Ord"],"Ord"],"constraintArgs":[{"tag":"TypeVar","contents":"k"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"k"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"v"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Types","MultiMap"],"MultiMap"]},{"tag":"TypeVar","contents":"k"}]},{"tag":"TypeVar","contents":"v"}]}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":"Constructs a `MultiMap` storing single key-value pair.\n"}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[202,1],"name":"src/Plutus/Types/AssocMap.purs","end":[202,63]},"score":0,"packageInfo":{"values":[],"tag":"LocalPackage"},"name":"singleton","moduleName":"Plutus.Types.AssocMap","info":{"values":[{"type":{"tag":"ForAll","contents":["k",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ForAll","contents":["v",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"k"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"v"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Plutus","Types","AssocMap"],"Map"]},{"tag":"TypeVar","contents":"k"}]},{"tag":"TypeVar","contents":"v"}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":"A singleton `Map`\n"}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[16,1],"name":".spago/mote/v1.1.0/src/Mote/Entry.purs","end":[16,46]},"score":0,"packageInfo":{"values":["mote"],"tag":"Package"},"name":"entry","moduleName":"Mote.Entry","info":{"values":[{"type":{"tag":"ForAll","contents":["b",{"tag":"ForAll","contents":["v",{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Prim"],"String"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"v"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Mote","Entry"],"Entry"]},{"tag":"TypeVar","contents":"b"}]},{"tag":"TypeVar","contents":"v"}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":"Creates an entry with the specifed label and no bracket action.\n"}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[17,1],"name":".spago/mote/v1.1.0/src/Mote/Description.purs","end":[17,51]},"score":0,"packageInfo":{"values":["mote"],"tag":"Package"},"name":"test","moduleName":"Mote.Description","info":{"values":[{"type":{"tag":"ForAll","contents":["b",{"tag":"ForAll","contents":["t",{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Prim"],"String"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"t"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Mote","Description"],"Description"]},{"tag":"TypeVar","contents":"b"}]},{"tag":"TypeVar","contents":"t"}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":"Basic constructor for `Test` with a label and value.\n"}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[110,1],"name":".spago/foreign/v6.0.1/src/Foreign.purs","end":[110,71]},"score":9,"packageInfo":{"values":["foreign"],"tag":"Package"},"name":"unsafeReadTagged","moduleName":"Foreign","info":{"values":[{"type":{"tag":"ForAll","contents":["m",{"tag":"ForAll","contents":["a",{"tag":"ConstrainedType","contents":[{"constraintClass":[["Control","Monad"],"Monad"],"constraintArgs":[{"tag":"TypeVar","contents":"m"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Prim"],"String"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Foreign"],"Foreign"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Foreign"],"FT"]},{"tag":"TypeVar","contents":"m"}]},{"tag":"TypeVar","contents":"a"}]}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":"Unsafely coerce a `Foreign` value when the value has a particular `tagOf`\nvalue.\n"}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[28,3],"name":".spago/foreign/v6.0.1/src/Foreign/Index.purs","end":[28,40]},"score":9,"packageInfo":{"values":["foreign"],"tag":"Package"},"name":"index","moduleName":"Foreign.Index","info":{"values":[{"typeClassArguments":[["i",null],["m",null]],"typeClass":[["Foreign","Index"],"Index"],"type":{"tag":"ForAll","contents":["i",{"tag":"ForAll","contents":["m",{"tag":"ConstrainedType","contents":[{"constraintClass":[["Foreign","Index"],"Index"],"constraintArgs":[{"tag":"TypeVar","contents":"i"},{"tag":"TypeVar","contents":"m"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Foreign"],"Foreign"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"i"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Foreign"],"FT"]},{"tag":"TypeVar","contents":"m"}]},{"tag":"TypeConstructor","contents":[["Foreign"],"Foreign"]}]}]}]}]},null]},null]}}],"tag":"TypeClassMemberResult"},"hashAnchor":"v","comments":null}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[101,1],"name":".spago/tuples/v6.0.1/src/Data/Tuple/Nested.purs","end":[101,43]},"score":35,"packageInfo":{"values":["tuples"],"tag":"Package"},"name":"tuple2","moduleName":"Data.Tuple.Nested","info":{"values":[{"type":{"tag":"ForAll","contents":["a",{"tag":"ForAll","contents":["b",{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"a"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"b"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Data","Tuple","Nested"],"Tuple2"]},{"tag":"TypeVar","contents":"a"}]},{"tag":"TypeVar","contents":"b"}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":"Given 2 values, creates a 2-tuple.\n"}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[190,1],"name":".spago/ordered-collections/v2.0.2/src/Data/Map/Internal.purs","end":[190,43]},"score":5,"packageInfo":{"values":["ordered-collections"],"tag":"Package"},"name":"singleton","moduleName":"Data.Map.Internal","info":{"values":[{"type":{"tag":"ForAll","contents":["k",{"tag":"ForAll","contents":["v",{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"k"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"v"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Data","Map","Internal"],"Map"]},{"tag":"TypeVar","contents":"k"}]},{"tag":"TypeVar","contents":"v"}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":"Create a map with one key/value pair\n"}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[292,1],"name":".spago/unordered-collections/v2.1.4/src/Data/HashMap.purs","end":[292,61]},"score":0,"packageInfo":{"values":["unordered-collections"],"tag":"Package"},"name":"singleton","moduleName":"Data.HashMap","info":{"values":[{"type":{"tag":"ForAll","contents":["k",{"tag":"ForAll","contents":["v",{"tag":"ConstrainedType","contents":[{"constraintClass":[["Data","Hashable"],"Hashable"],"constraintArgs":[{"tag":"TypeVar","contents":"k"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"k"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"v"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Data","HashMap"],"HashMap"]},{"tag":"TypeVar","contents":"k"}]},{"tag":"TypeVar","contents":"v"}]}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":"A map of one key and its associated value.\n\n`singleton k v == insert k v empty`\n"}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[79,1],"name":".spago/sequences/v3.0.2/src/Data/FingerTree.purs","end":[79,68]},"score":0,"packageInfo":{"values":["sequences"],"tag":"Package"},"name":"node2","moduleName":"Data.FingerTree","info":{"values":[{"type":{"tag":"ForAll","contents":["a",{"tag":"ForAll","contents":["v",{"tag":"ConstrainedType","contents":[{"constraintClass":[["Data","Monoid"],"Monoid"],"constraintArgs":[{"tag":"TypeVar","contents":"v"}]},{"tag":"ConstrainedType","contents":[{"constraintClass":[["Data","Sequence","Internal"],"Measured"],"constraintArgs":[{"tag":"TypeVar","contents":"a"},{"tag":"TypeVar","contents":"v"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"a"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"a"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Data","FingerTree"],"Node"]},{"tag":"TypeVar","contents":"v"}]},{"tag":"TypeVar","contents":"a"}]}]}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":null}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[39,1],"name":".spago/transformers/v5.2.0/src/Control/Comonad/Env.purs","end":[39,37]},"score":19,"packageInfo":{"values":["transformers"],"tag":"Package"},"name":"env","moduleName":"Control.Comonad.Env","info":{"values":[{"type":{"tag":"ForAll","contents":["e",{"tag":"ForAll","contents":["a",{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"e"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"a"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Control","Comonad","Env"],"Env"]},{"tag":"TypeVar","contents":"e"}]},{"tag":"TypeVar","contents":"a"}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":"Create a value in context in the `Env` comonad.\n"}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[185,1],"name":"src/Contract/Test/Utils.purs","end":[190,21]},"score":0,"packageInfo":{"values":[],"tag":"LocalPackage"},"name":"assertContract","moduleName":"Contract.Test.Utils","info":{"values":[{"type":{"tag":"ForAll","contents":["r",{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Row"]},{"tag":"TypeConstructor","contents":[["Prim"],"Type"]}]},{"tag":"ForAll","contents":["e",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ConstrainedType","contents":[{"constraintClass":[["Data","Show"],"Show"],"constraintArgs":[{"tag":"TypeVar","contents":"e"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"e"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Prim"],"Boolean"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Contract","Monad"],"Contract"]},{"tag":"TypeVar","contents":"r"}]},{"tag":"TypeConstructor","contents":[["Data","Unit"],"Unit"]}]}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":null}],"tag":"SearchResult"},{"values":[{"sourceSpan":{"start":[59,1],"name":"src/Contract/AuxiliaryData.purs","end":[64,39]},"score":0,"packageInfo":{"values":[],"tag":"LocalPackage"},"name":"setTxMetadata","moduleName":"Contract.AuxiliaryData","info":{"values":[{"type":{"tag":"ForAll","contents":["r",{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Row"]},{"tag":"TypeConstructor","contents":[["Prim"],"Type"]}]},{"tag":"ForAll","contents":["m",{"tag":"TypeConstructor","contents":[["Prim"],"Type"]},{"tag":"ConstrainedType","contents":[{"constraintClass":[["Metadata","MetadataType"],"MetadataType"],"constraintArgs":[{"tag":"TypeVar","contents":"m"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeConstructor","contents":[["Types","ScriptLookups"],"UnattachedUnbalancedTx"]}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Prim"],"Function"]},{"tag":"TypeVar","contents":"m"}]},{"tag":"TypeApp","contents":[{"tag":"TypeApp","contents":[{"tag":"TypeConstructor","contents":[["Contract","Monad"],"Contract"]},{"tag":"TypeVar","contents":"r"}]},{"tag":"TypeConstructor","contents":[["Types","ScriptLookups"],"UnattachedUnbalancedTx"]}]}]}]}]},null]},null]}}],"tag":"ValueResult"},"hashAnchor":"v","comments":null}],"tag":"SearchResult"}]