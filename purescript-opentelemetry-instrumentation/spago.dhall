{ name = "purescript-opentelemetry-instrumentation"
, dependencies = [ "console", "effect", "prelude", "nullable", "psci-support", "purescript-opentelemetry-sdk-trace-base" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
