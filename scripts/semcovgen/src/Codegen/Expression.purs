module Codegen.Expression where

import Codegen.Function
import Prelude
import Prim hiding (Function)

import Data.Foldable (intercalate)
import Data.String.Extra (pascalCase)

data Expression = FunctionExpr Function | DataExpr Data | TypeclassExpr 

instance showExpression :: Show Expression where
  show (FunctionExpr function) = show function
  show TypeclassExpr = "todo"
  show (DataExpr data_) = show data_

data Data = Data {
  name :: String,
  variants :: Array String
}

instance showData :: Show Data where
  show (Data {
    name: name, 
    variants: variants
  }) = intercalate " " ["data", pascalCase name, "=", (intercalate " | " variants)]
