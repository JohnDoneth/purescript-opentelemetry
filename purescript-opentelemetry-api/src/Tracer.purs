module OpenTelemetry.API.Tracer where

import Prelude

import Effect (Effect)
import Effect.Class
import Data.Maybe

import OpenTelemetry.API.Span (Span)

foreign import data Tracer :: Type

foreign import startSpan :: Tracer -> String -> Effect Span

foreign import startActiveSpan :: forall m a. MonadEffect m => Tracer -> String -> Function Span (m a) -> m a