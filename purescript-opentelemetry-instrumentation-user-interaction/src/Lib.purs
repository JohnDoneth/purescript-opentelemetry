module OpenTelemetry.InstrumentationUserInteraction where


import Prelude
import Effect (Effect)

import OpenTelemetry.Instrumentation (Instrumentation)

foreign import userInteractionInstrumentation :: Effect Instrumentation
