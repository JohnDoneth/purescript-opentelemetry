module Codegen.Expression where

import Codegen.Function
import Prelude
import Prim hiding (Function)

import Control.Monad.Writer.Class (class MonadTell, tell)
import Data.Foldable (intercalate)
import Data.String.Extra (pascalCase)
import Data.Traversable (for_)

data Expression = FunctionExpr Function | DataExpr Data | TypeclassExpr Typeclass

data Data = Data {
  name :: String,
  variants :: Array String
}

data Typeclass = Typeclass {
  typeclass :: String,
  type_ :: String,
  body :: Array TypeclassBody
}

data TypeclassBody = TypeclassBody {
  function :: String,
  args :: String,
  expression :: String
}

encodeTypeclass :: forall m. MonadTell String m => Typeclass -> m Unit
encodeTypeclass (Typeclass typeclass) = do
  tellLine $ "instance " <> typeclass.typeclass <> " " <>  typeclass.type_ <> " where"
  
  for_ typeclass.body \(TypeclassBody item) -> do
    tellLine $ "  " <> item.function <> " " <> item.args <> " = " <> item.expression


encodeData :: forall m. MonadTell String m => Data -> m Unit
encodeData (Data {
    name: name, 
    variants: variants
  }) = do
  tellLine $ intercalate " " ["data", pascalCase name, "=", (intercalate " | " variants)]

encodeExpression :: forall m. MonadTell String m => Expression -> m Unit
encodeExpression (FunctionExpr function) = encodeFunction function
encodeExpression (TypeclassExpr expr) = encodeTypeclass expr
encodeExpression (DataExpr data_) = encodeData data_