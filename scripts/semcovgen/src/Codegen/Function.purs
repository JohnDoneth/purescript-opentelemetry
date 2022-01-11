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

import Control.Monad.Writer.Class
import Prelude
import Prim hiding (Function)

import Data.Array (concat)
import Data.Foldable (fold, intercalate)
import Data.Traversable (for_, sequence)

newtype Function = Function {
    doc :: Array String,
    name :: String,
    type_ :: Array String,
    args :: Array String,
    value :: String
}

tellLine :: forall m. MonadTell String m => String -> m Unit
tellLine input = do
  tell input
  tell "\n"

encodeDocString :: forall m. MonadTell String m => Array String -> m Unit
encodeDocString docs = do
  for_ docs \item -> do
    tellLine ("-- | " <> item)

encodeFunctionType :: forall m. MonadTell String m => String -> Array String  -> m Unit
encodeFunctionType name type_ = do
  tellLine $ name <> " :: " <> (intercalate " -> " type_)

encodeFunctionDefinition :: forall m. MonadTell String m => String -> Array String -> String -> m Unit
encodeFunctionDefinition name args value = do
  tellLine $ name <> " " <> (intercalate " " args) <> " = " <> value

--encodeFunction :: Function -> MonadWriter String
encodeFunction :: forall m. MonadTell String m => Function -> m Unit
encodeFunction (Function {
      doc: doc, 
      name: name,
      type_: type_, 
      args: args, 
      value: value
    }) = do
  encodeDocString doc
  encodeFunctionType name type_
  encodeFunctionDefinition name args value

emptyLine :: String 
emptyLine = ""

