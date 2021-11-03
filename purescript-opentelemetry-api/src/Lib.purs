module OpenTelemetry.API where

import Prelude

import Effect (Effect)
import Effect.Class
import Control.Applicative (pure)

import OpenTelemetry.API.Tracer (Tracer)
import OpenTelemetry.API.Tracer as Tracer
import OpenTelemetry.API.Span as Span
import OpenTelemetry.API.Span (Span)


-- | Retrieves the global tracer
foreign import trace :: Effect Tracer

--withSpan :: forall m a. MonadEffect m => Tracer -> String -> m a -> m a 

withSpan :: forall m a. MonadEffect m => Tracer -> String -> Function Span (m a) -> m a
withSpan tracer spanName function = do
    span <- liftEffect $ Tracer.startSpan tracer spanName
    result <- function span
    liftEffect $ Span.end span
    pure result