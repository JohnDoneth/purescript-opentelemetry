module OpenTelemetry.InstrumentationDocumentLoad where


import Prelude
import Effect (Effect)

import OpenTelemetry.Instrumentation (Instrumentation)

foreign import documentLoadInstrumentation :: Effect Instrumentation
