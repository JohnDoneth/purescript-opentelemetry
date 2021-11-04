module OpenTelemetry.InstrumentationFetch where


import Prelude
import Effect (Effect)

import OpenTelemetry.Instrumentation (Instrumentation)

foreign import fetchInstrumentation :: Effect Instrumentation
