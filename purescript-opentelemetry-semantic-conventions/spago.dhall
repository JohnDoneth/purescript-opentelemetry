{ name = "purescript-opentelemetry-core"
, dependencies =
  [ "console"
  , "effect"
  , "prelude"
  , "psci-support"
  , "pairs"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
