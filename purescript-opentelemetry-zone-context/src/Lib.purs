module OpenTelemetry.ZoneContext where


import Prelude
import Effect (Effect)

import OpenTelemetry.API.Context (ContextManager)

foreign import zoneContextManager :: Effect ContextManager
