module Repr.AttributeSpec where

import Prelude

import Data.Either (Either(..))
import Parsing (parse)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Repr.Attribute
import Data.Maybe
import Repr.AttributeType

parseAttribute :: String -> Either String Attribute
parseAttribute = parse

spec :: Spec Unit
spec = do
  describe "Attribute" $ do
    it "string" $ do
      parseAttribute """
      id: type
      type: string
      brief: description here
      examples: ["java.net.ConnectException", "OSError"]
      """ `shouldEqual` (Right (Definition { 
          brief: "description here", 
          examples: [], 
          id: "type", 
          samplingRelevant: false, 
          tag: Nothing, 
          type_: String 
        }))


    