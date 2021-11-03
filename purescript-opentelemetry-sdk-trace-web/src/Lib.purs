module OpenTelemetry.SDKTraceWeb (
    webTracerProvider, 
    WebTracerProvider, 
    addSpanProcessor,
    getTracer,
    registerContextManager
) where

import OpenTelemetry.API.Tracer (Tracer)
import OpenTelemetry.API.Context (ContextManager)
import OpenTelemetry.SDKTraceBase (SpanProcessor)

import Prelude
import Effect (Effect)

foreign import data WebTracerProvider :: Type

foreign import webTracerProvider :: Effect WebTracerProvider

foreign import addSpanProcessor :: WebTracerProvider -> SpanProcessor -> Effect Unit

foreign import getTracer :: WebTracerProvider -> String -> Effect Tracer

foreign import registerContextManager :: WebTracerProvider -> ContextManager -> Effect Unit