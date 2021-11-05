{ name = "purescript-opentelemetry-exporter-jaeger"
, dependencies = [ "console", "effect", "prelude", "psci-support", "maybe", "nullable", "purescript-opentelemetry-sdk-trace-base" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
