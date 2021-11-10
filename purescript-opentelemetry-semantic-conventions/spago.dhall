{ name = "purescript-opentelemetry-core"
, dependencies =
  [ "argonaut-codecs"
  , "argonaut-core"
  , "argonaut-generic"
  , "console"
  , "effect"
  , "either"
  , "foreign"
  , "lists"
  , "maybe"
  , "prelude"
  , "psci-support"
  , "transformers"
  , "yaml-next"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
