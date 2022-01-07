{ name = "purescript-opentelemetry-instrumentation"
, dependencies =
  [ "console"
  , "effect"
  , "maybe"
  , "nullable"
  , "prelude"
  , "psci-support"
  ]
, packages = ../packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
