module OpenTelemetry.API.Context where

import Prelude
import Data.Nullable
import Foreign

foreign import data ContextManager :: Type

foreign import data Context :: Type

class ContextClass context where
  getValue :: context -> Symbol -> Foreign

  setValue :: forall v. context -> Symbol -> v -> Context

  deleteValue :: context -> Symbol -> Context

--foreign import instance cContextClass :: ContextClass Context 