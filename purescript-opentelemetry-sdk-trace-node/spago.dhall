{ name = "purescript-opentelemetry-sdk-trace-node"
, dependencies = [ "console", "effect", "prelude", "psci-support", "purescript-opentelemetry-sdk-trace-base" ]
, packages = ../packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
