module OpenTelemetry.SDKTraceWeb (
    webTracerProvider, 
    WebTracerProvider, 
    addSpanProcessor,
    getTracer,
    Tracer
) where

import OpenTelemetry.SDKTraceBase (SpanProcessor)
import Prelude
import Effect (Effect)

foreign import data WebTracerProvider :: Type

foreign import data Tracer :: Type

foreign import webTracerProvider :: Effect WebTracerProvider

foreign import addSpanProcessor :: WebTracerProvider -> SpanProcessor -> Effect Unit

foreign import getTracer :: WebTracerProvider -> String -> Tracer