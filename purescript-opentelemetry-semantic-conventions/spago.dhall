{ name = "purescript-opentelemetry-core"
, dependencies = [ "console", "effect", "prelude", "maybe", "psci-support", "aff-promise", "purescript-opentelemetry-api", "aff" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
