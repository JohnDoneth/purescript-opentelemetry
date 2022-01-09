{ name = "semcovgen"
, dependencies =
  [ "argonaut-codecs"
  , "argonaut-core"
  , "arrays"
  , "console"
  , "control"
  , "effect"
  , "either"
  , "exceptions"
  , "foldable-traversable"
  , "maybe"
  , "node-buffer"
  , "node-fs"
  , "node-path"
  , "ordered-collections"
  , "prelude"
  , "psci-support"
  , "spec"
  , "strings-extra"
  , "strings"
  , "transformers"
  , "tuples"
  , "yaml-next"
  , "aff"
  ]
, packages = ../../packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
