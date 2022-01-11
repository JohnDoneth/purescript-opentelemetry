{ name = "node-server-example"
, dependencies =
  [ "aff"
  , "console"
  , "effect"
  , "httpure"
  , "maybe"
  , "prelude"
  , "psci-support"
  , "purescript-opentelemetry-api"
  , "purescript-opentelemetry-exporter-collector"
  , "purescript-opentelemetry-exporter-otlp-http"
  , "purescript-opentelemetry-instrumentation"
  , "purescript-opentelemetry-sdk-trace-base"
  , "purescript-opentelemetry-sdk-trace-node"
  , "purescript-opentelemetry-zone-context"
  , "purescript-opentelemetry-instrumentation-http"
  , "purescript-opentelemetry-semantic-conventions"
  ]
, packages = ../../packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
