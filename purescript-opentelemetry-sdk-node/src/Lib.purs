module OpenTelemetry.NodeSDK where

import OpenTelemetry.SDKTraceBase (Exporter)

import Prelude
import Effect (Effect)

foreign import data NodeSDK :: Type

foreign import nodeSDK :: Exporter -> Effect NodeSDK

foreign import start :: NodeSDK -> Effect Unit
