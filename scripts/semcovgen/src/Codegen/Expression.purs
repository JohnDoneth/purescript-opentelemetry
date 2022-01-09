module Codegen.Expression where

import Codegen.Function
import Prelude
import Prim hiding (Function)

import Control.Monad.Writer.Class (class MonadTell, tell)
import Data.Foldable (intercalate)
import Data.String.Extra (pascalCase)

data Expression = FunctionExpr Function | DataExpr Data | TypeclassExpr 

data Data = Data {
  name :: String,
  variants :: Array String
}

encodeData :: forall m. MonadTell String m => Data -> m Unit
encodeData (Data {
    name: name, 
    variants: variants
  }) = do
  tellLine $ intercalate " " ["data", pascalCase name, "=", (intercalate " | " variants)]

encodeExpression :: forall m. MonadTell String m => Expression -> m Unit
encodeExpression (FunctionExpr function) = encodeFunction function
encodeExpression TypeclassExpr = pure unit
encodeExpression (DataExpr data_) = encodeData data_