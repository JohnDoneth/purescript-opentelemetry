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
  , "purescript-opentelemetry-sdk-trace-base"
  , "purescript-opentelemetry-sdk-trace-web"
  , "purescript-opentelemetry-zone-context"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
