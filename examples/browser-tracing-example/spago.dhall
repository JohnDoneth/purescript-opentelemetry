{ name = "browser-tracing-example"
, dependencies =
  [ "console"
  , "effect"
  , "maybe"
  , "prelude"
  , "psci-support"
  , "purescript-opentelemetry-api"
  , "purescript-opentelemetry-instrumentation"
  , "purescript-opentelemetry-instrumentation-fetch"
  , "purescript-opentelemetry-instrumentation-user-interaction"
  , "purescript-opentelemetry-instrumentation-document-load"
  , "purescript-opentelemetry-sdk-trace-base"
  , "purescript-opentelemetry-sdk-trace-web"
  , "purescript-opentelemetry-zone-context"
  , "purescript-opentelemetry-exporter-otlp-http"
  , "purescript-opentelemetry-exporter-collector"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
