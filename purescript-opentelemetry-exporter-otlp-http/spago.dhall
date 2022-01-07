{ name = "purescript-opentelemetry-exporter-trace-oltp-http"
, dependencies = [ "console", "effect", "prelude", "psci-support", "maybe", "nullable", "purescript-opentelemetry-sdk-trace-base" ]
, packages = ../packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
