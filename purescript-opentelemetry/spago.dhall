{ name = "purescript-opentelemetry"
, dependencies =
  [ 
    "purescript-opentelemetry-api"
    ,"purescript-opentelemetry-core"
    ,"purescript-opentelemetry-exporter-collector"
    ,"purescript-opentelemetry-exporter-jaeger"
    ,"purescript-opentelemetry-exporter-otlp-http"
    ,"purescript-opentelemetry-instrumentation"
    ,"purescript-opentelemetry-instrumentation-document-load"
    ,"purescript-opentelemetry-instrumentation-fetch"
    ,"purescript-opentelemetry-instrumentation-http"
    ,"purescript-opentelemetry-instrumentation-user-interaction"
    ,"purescript-opentelemetry-propagator-b3"
    ,"purescript-opentelemetry-sdk-trace-base"
    ,"purescript-opentelemetry-sdk-trace-node"
    ,"purescript-opentelemetry-sdk-trace-web"
    ,"purescript-opentelemetry-semantic-conventions"
    ,"purescript-opentelemetry-zone-context"
  ]
, packages = ../packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
