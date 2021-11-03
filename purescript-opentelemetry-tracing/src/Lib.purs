module OpenTelemetry.Tracing where


foreign import data Tracer :: Type

--foreign import startSpan :: String -> SpanOptions -> Effect Exporter
foreign import startSpan :: String -> Effect Exporter