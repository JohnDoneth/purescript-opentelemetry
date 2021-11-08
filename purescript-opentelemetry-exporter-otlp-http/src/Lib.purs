module OpenTelemetry.OTLPHTTPExporter (newOTLPHTTPExporter, ExporterOptions, exporterOptions) where

import Prelude

import Data.Maybe
import Data.Nullable
import Effect (Effect)

import OpenTelemetry.SDKTraceBase (Exporter)

-- | Options for calling `newOTLPHTTPExporter`.
type ExporterOptions =
  { hostname :: Maybe String
  , url :: Maybe String
  , concurrencyLimit :: Maybe Number
  }

-- | Default exporter options with nothing specified.
exporterOptions :: ExporterOptions
exporterOptions =
  {
    --headers : [], #TODO
    hostname: Nothing
  ,
    --attributes : Nothing, #TODO
    url: Nothing
  , concurrencyLimit: Nothing
  }

type ExporterOptionsFFI =
  { hostname :: Nullable String
  , url :: Nullable String
  , concurrencyLimit :: Nullable Number
  }

toFFI :: ExporterOptions -> ExporterOptionsFFI
toFFI options =
  { hostname: toNullable options.hostname
  , url: toNullable options.url
  , concurrencyLimit: toNullable options.concurrencyLimit
  }

-- | Creates a new Trace/Metrics exporter that sends collected trace and metrics
-- | data over HTTP using OTLP encoding.
newOTLPHTTPExporter :: ExporterOptions -> Effect Exporter
newOTLPHTTPExporter options = newOTLPHTTPExporterFFI $ toFFI options

foreign import newOTLPHTTPExporterFFI :: ExporterOptionsFFI -> Effect Exporter
