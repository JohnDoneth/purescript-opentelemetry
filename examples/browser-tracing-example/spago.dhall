{ name = "browser-tracing-example"
, dependencies =
  [ "console"
  , "effect"
  , "maybe"
  , "prelude"
  , "psci-support"
  , "purescript-opentelemetry-api"
  , "purescript-opentelemetry-core"
  , "purescript-opentelemetry-exporter-collector"
  , "purescript-opentelemetry-instrumentation"
  , "purescript-opentelemetry-instrumentation-document-load"
  , "purescript-opentelemetry-instrumentation-fetch"
  , "purescript-opentelemetry-instrumentation-user-interaction"
  , "purescript-opentelemetry-propagator-b3"
  , "purescript-opentelemetry-sdk-trace-base"
  , "purescript-opentelemetry-sdk-trace-web"
  , "purescript-opentelemetry-zone-context"
  , "tuples"
  ]
, packages = ../../packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
