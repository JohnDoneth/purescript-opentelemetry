module OpenTelemetry.API.Tracer where

import Prelude

import Effect (Effect)
import Effect.Class
import Effect.Aff (Aff)
import Data.Maybe
import Effect.Aff.Compat
import Control.Promise

import OpenTelemetry.API.Span (Span)
import OpenTelemetry.API.Span as Span

foreign import data Tracer :: Type

foreign import startSpan :: Tracer -> String -> Effect Span

foreign import startActiveSpan :: forall a. Tracer -> String -> (Span -> Effect a) -> Effect a

foreign import startActiveSpanPromise
  :: forall a
   . Tracer
  -> String
  -> (Span -> Effect (Promise a))
  -> Promise a

-- Starts a new active span in an `Aff` context.
startActiveSpanAff
  :: forall a
   . Tracer
  -> String
  -> (Span -> Aff a)
  -> Aff a
startActiveSpanAff tracer spanName callback =
  toAff $ startActiveSpanPromise tracer spanName spanToPromise
  where
  -- Converts `Span -> Aff a` to `Span -> Effect (Promise a)`
  spanToPromise :: Span -> Effect (Promise a)
  spanToPromise = \span -> fromAff $ (callback span)