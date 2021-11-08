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

--foreign import startActiveSpanAff :: forall a. Tracer -> String -> (Span -> Aff a) -> Aff a


foreign import startActiveSpanFFI :: forall a. Tracer -> String -> (Span -> a) -> a

foreign import startActiveSpanPromise :: 
    forall a. 
    Tracer 
    -> String 
    -> (Span -> Effect (Promise a))
    -> Promise a

startActiveSpan2 :: 
    forall a. 
    Tracer 
    -> String 
    -> (Span -> Aff a) 
    -> Aff a
startActiveSpan2 tracer spanName callback = 
    toAff $ startActiveSpanPromise tracer spanName func
    where 
        func :: Span -> Effect (Promise a)
        func = \span -> fromAff $ (callback span) 



-- foreign import startActiveSpan :: forall m a. Tracer -> String -> Function Span (Effect a) -> Effect a

-- foreign import startActiveSpanEffectFnAff :: forall m a. Tracer -> String -> (Span -> (Aff a)) -> EffectFnAff a

-- startActiveSpanAff :: forall m a. Tracer -> String -> (Span -> (Aff a)) -> Aff a
-- startActiveSpanAff tracer spanName callback =
--     fromEffectFnAff $ startActiveSpanEffectFnAff tracer spanName callback



-- startActiveSpanHL :: forall a. Tracer -> String -> (Span -> Aff a) -> Aff a
-- startActiveSpanHL tracer spanName callback = do
--     fromEffectFnAff $ startActiveSpan tracer spanName $ \span -> do
--         result <- callback span
--         Span.end span
--         pure result

-- --   // tracer.startActiveSpan(spanName, function(span) {
-- --   //   console.log("start");
-- --   //   let result = func.call(this, span)();
-- --   //   span.end();
-- --   //   console.log("stop");
-- --   //   onSuccess(result);
-- --   // });