module OpenTelemetry.API where

import Prelude

import Effect (Effect)
import Effect.Class
import Control.Applicative (pure)

import OpenTelemetry.API.Tracer (Tracer)
import OpenTelemetry.API.Tracer as Tracer
import OpenTelemetry.API.Span as Span
import OpenTelemetry.API.Span (Span)

import Effect.Console (log)

-- | Retrieves a global tracer
foreign import getTracer :: String -> Effect Tracer

foreign import data Propagater :: Type

foreign import setGlobalPropagator :: Propagater -> Effect Unit