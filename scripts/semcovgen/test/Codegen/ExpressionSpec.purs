module Test.Codegen.ExpressionSpec where

import Prelude

import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Data.Tuple (snd)
import Codegen.Expression (Expression(..), Typeclass(..), TypeclassBody(..), encodeExpression)
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
          expressionAsString (TypeclassExpr (Typeclass {
            typeclass: "Show",
            type_: "DbSystem",
            body: [
              (TypeclassBody {function: "show", args: "OTHER_SQL", expression: "\"other_sql\""}),
              (TypeclassBody {function: "show", args: "MSSQL", expression: "\"mssql\""}),
              (TypeclassBody {function: "show", args: "MYSQL", expression: "\"mysql\""}),
              (TypeclassBody {function: "show", args: "(CustomSQL custom)", expression: "custom"})
            ]
          }))
            `shouldEqual` expectedTypeclassOutput
    

expectedTypeclassOutput ∷ String
expectedTypeclassOutput = """instance Show DbSystem where
  show OTHER_SQL = "other_sql"
  show MSSQL = "mssql"
  show MYSQL = "mysql"
  show (CustomSQL custom) = custom
"""