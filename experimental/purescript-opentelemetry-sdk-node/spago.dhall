{ name = "purescript-opentelemetry-sdk-node"
, dependencies = [ "console", "effect", "prelude", "psci-support", "purescript-opentelemetry-sdk-trace-base" ]
, packages = ../packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
