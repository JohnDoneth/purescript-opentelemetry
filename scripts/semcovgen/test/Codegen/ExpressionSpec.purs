module Test.Codegen.ExpressionSpec where

import Prelude

import Data.Either (Either(..))
import Parsing (parse)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Repr.AttributeType (AttributeType(..), EnumMember(..))
import Data.Map as Map
import Data.Tuple
import Codegen.Expression (Expression(..), encodeExpression)
import Control.Monad.Writer (runWriter)

expressionAsString :: Expression -> String
expressionAsString expression =
    snd $ runWriter $ encodeExpression expression


spec :: Spec Unit
spec = do
  describe "Codegen" $ do
    describe "Expression" $ do
        describe "encodeExpression" $ do
            it "encodes typeclass expressions" $ do
                expressionAsString TypeclassExpr `shouldEqual` ""
    