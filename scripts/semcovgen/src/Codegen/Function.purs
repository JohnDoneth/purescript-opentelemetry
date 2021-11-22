-- |
-- | Represents a PureScript function source definition.
-- |
-- |    show Function { doc: [], name: "invokeArn", type_: ["String", "Pair String"], args: ["input"], value: "Pair \"aws.lambda.invoked_arn\" input" }
-- |
-- | Becomes:
-- |
-- |    invokedArn :: String -> Pair String
-- |    invokedArn input = Pair "aws.lambda.invoked_arn" input
-- |
module Codegen.Function where

import Prelude
import Prim hiding (Function)

import Data.Array (concat)
import Data.Foldable (fold, intercalate)

newtype Function = Function {
    doc :: Array String,
    name :: String,
    type_ :: Array String,
    args :: Array String,
    value :: String
}

instance showFunction :: Show Function where
  show (Function {
      doc: doc, 
      name: name,
      type_: type_, 
      args: args, 
      value: value
    }) = [
        map (\item -> "-- | " <> item) doc,
        [
            name <> " :: " <> (intercalate " -> " type_),
            name <> " " <> (intercalate " " args) <> " = " <> value
        ]
    ]
    # concat
    # map line
    # fold


line :: String -> String
line string = string <> "\n"

emptyLine :: String 
emptyLine = ""

