{ name = "purescript-opentelemetry-exporter-collector"
, dependencies = [ "console", "effect", "prelude", "psci-support", "foreign-object", "maybe", "nullable", "purescript-opentelemetry-sdk-trace-base" ]
, packages = ../packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
