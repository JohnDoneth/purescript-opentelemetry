module OpenTelemetry.JaegerExporter (jaegerExporter, ExporterOptions, exporterOptions, Tag, TagValue) where


import OpenTelemetry.SDKTraceBase (Exporter)

import Prelude
import Effect (Effect)
import Data.Maybe
import Data.Nullable

type Tag = {
    key :: String,
    value :: TagValue
}

data TagValue = 
    StringTag String | 
    NumberTag Number | 
    BooleanTag Boolean

type ExporterOptions = {
    -- #TODO: These tags need to be properly transformed into the right JavaScript entities they represent
    tags :: Array Tag, 
    host :: Maybe String,
    port :: Maybe Number,
    maxPacketSize :: Maybe Number,
    flushTimeout :: Maybe Number,
    endpoint :: Maybe Number,
    username :: Maybe Number,
    password :: Maybe Number
}

-- | Default exporter options with nothing specified.
exporterOptions :: ExporterOptions
exporterOptions = {
    tags : [],
    host : Nothing,
    port : Nothing,
    maxPacketSize: Nothing,
    flushTimeout : Nothing,
    endpoint : Nothing,
    username : Nothing,
    password : Nothing
}

type ExporterOptionsFFI = {
    tags :: Array Tag,
    host :: Nullable String,
    port :: Nullable Number,
    maxPacketSize :: Nullable Number,
    flushTimeout :: Nullable Number,
    endpoint :: Nullable Number,
    username :: Nullable Number,
    password :: Nullable Number
}

toFFI :: ExporterOptions -> ExporterOptionsFFI
toFFI options = {
    tags : options.tags,
    host : toNullable options.host,
    port : toNullable options.port,
    maxPacketSize: toNullable options.maxPacketSize,
    flushTimeout : toNullable options.flushTimeout,
    endpoint : toNullable options.endpoint,
    username : toNullable options.username,
    password : toNullable options.password
}

jaegerExporter :: ExporterOptions -> Effect Exporter
jaegerExporter options = jaegerExporterFFI $ toFFI options

foreign import jaegerExporterFFI :: ExporterOptionsFFI -> Effect Exporter
