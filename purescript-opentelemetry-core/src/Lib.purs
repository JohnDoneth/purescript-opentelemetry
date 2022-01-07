module OpenTelemetry.Core where

import Prelude
import Effect (Effect)

import OpenTelemetry.API (Propagater)

-- | OpenTelemetry provides a text-based approach to propagate context to remote
-- | services using the [W3C Trace
-- | Context](https://www.w3.org/TR/trace-context/) HTTP headers.
foreign import w3CTraceContextPropagator :: Effect Propagater

