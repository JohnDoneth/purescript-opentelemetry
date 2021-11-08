module OpenTelemetry.Instrumentation
  ( registerInstrumentations
  , AutoLoaderOptions
  , Instrumentation
  , TracerProvider
  , MeterProvider
  ) where

import Prelude
import Effect (Effect)
import Data.Maybe
import Data.Nullable

import OpenTelemetry.API.Context (ContextManager)

foreign import data Instrumentation :: Type
foreign import data TracerProvider :: Type
foreign import data MeterProvider :: Type

type AutoLoaderOptions =
  { instrumentations :: Array Instrumentation
  , tracerProvider :: Maybe TracerProvider
  , meterProvider :: Maybe MeterProvider
  }

type AutoLoaderOptionsFFI =
  { instrumentations :: Array Instrumentation
  , tracerProvider :: Nullable TracerProvider
  , meterProvider :: Nullable MeterProvider
  }

-- | Register instrumentations and plugins
-- |
-- | returns a function to unload instrumentation and plugins that were registered
foreign import registerInstrumentationsFFI :: AutoLoaderOptionsFFI -> Effect (Unit -> Unit)

optionsToFFI :: AutoLoaderOptions -> AutoLoaderOptionsFFI
optionsToFFI options =
  { instrumentations: options.instrumentations
  , tracerProvider: toNullable options.tracerProvider
  , meterProvider: toNullable options.meterProvider
  }

registerInstrumentations :: AutoLoaderOptions -> Effect (Unit -> Unit)
registerInstrumentations options = registerInstrumentationsFFI $ optionsToFFI options