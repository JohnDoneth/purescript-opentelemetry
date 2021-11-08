{ name = "purescript-opentelemetry-api"
, dependencies = [ "console", "effect", "prelude", "maybe", "psci-support", "aff-promise", "purescript-opentelemetry-sdk-trace-base", "aff" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
