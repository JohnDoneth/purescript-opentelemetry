module OpenTelemetry.B3Propagator where

import Prelude
import Effect (Effect)

import OpenTelemetry.API (Propagater)

foreign import b3PropogatorSingleHeader :: Effect Propagater

foreign import b3PropogatorMultiHeader :: Effect Propagater
