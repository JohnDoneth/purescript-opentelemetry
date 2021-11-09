module OpenTelemetry.InstrumentationHTTP where

import Prelude
import Effect (Effect)

import OpenTelemetry.Instrumentation (Instrumentation)

foreign import httpInstrumentation :: Effect Instrumentation
