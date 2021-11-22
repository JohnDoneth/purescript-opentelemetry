module Codegen.Expression where

import Prim hiding (Function)
import Prelude
import Codegen.Function

data Expression = FunctionExpr Function

instance showExpression :: Show Expression where
  show (FunctionExpr function) = show function