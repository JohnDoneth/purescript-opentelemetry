module OpenTelemetry.SDKTraceBase (
    registerBasicTracerProvider, 
    wrapSimpleSpanProcessor, 
    consoleExporter,
    Exporter, 
    SpanProcessor
) where

import Prelude
import Effect (Effect)

foreign import data Exporter :: Type
foreign import data SpanProcessor :: Type

foreign import registerBasicTracerProvider :: Effect Unit

foreign import consoleExporter :: Effect Exporter

-- | Wraps an exporter with a simple span processor.
foreign import wrapSimpleSpanProcessor :: Exporter -> SpanProcessor
