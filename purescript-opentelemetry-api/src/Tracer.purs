module OpenTelemetry.API.Tracer where

import Prelude

import Effect (Effect)
import Data.Maybe

import OpenTelemetry.API.Span (Span)

foreign import data Tracer :: Type

foreign import startSpan :: Tracer -> String -> Effect Span
