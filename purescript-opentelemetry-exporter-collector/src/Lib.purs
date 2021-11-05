module OpenTelemetry.CollectorExporter (collectorTraceExporter, ExporterOptions, exporterOptions) where

import Prelude

import Data.Maybe
import Data.Nullable
import Effect (Effect)
import Foreign.Object
import Data.Tuple

import OpenTelemetry.SDKTraceBase (Exporter)

-- | Options for calling `collectorTraceExporter`.
type ExporterOptions = {
    headers :: Array (Tuple String String), -- header/value pairs.
    hostname :: Maybe String,
    url:: Maybe String,
    concurrencyLimit:: Maybe Number
}

-- | Default exporter options with nothing specified.
exporterOptions :: ExporterOptions
exporterOptions = {
    headers : [],
    hostname : Nothing,
    --attributes : Nothing, #TODO
    url: Nothing,
    concurrencyLimit: Nothing
}

-- How the options are represented in JavaScript.
type ExporterOptionsFFI = {
    headers :: Object String,
    hostname :: Nullable String,
    url:: Nullable String,
    concurrencyLimit:: Nullable Number
}

toFFI :: ExporterOptions -> ExporterOptionsFFI
toFFI options = {
    headers : fromFoldable options.headers,
    hostname : toNullable options.hostname,
    url : toNullable options.url,
    concurrencyLimit: toNullable options.concurrencyLimit
}

-- | Creates a new Trace/Metrics exporter that sends collected trace and metrics
-- | data over HTTP using OTLP encoding.
collectorTraceExporter :: ExporterOptions -> Effect Exporter
collectorTraceExporter options = collectorTraceExporterFFI $ toFFI options

foreign import collectorTraceExporterFFI :: ExporterOptionsFFI -> Effect Exporter
