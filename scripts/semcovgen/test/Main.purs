module Test.Main where

import Prelude

import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Parsing (parseGroups)
import Repr.AttributeTypeSpec as AttributeTypeSpec
import Repr.AttributeSpec as AttributeSpec

import Repr.Groups (Groups(..))
import Repr.SemanticConvention (SemanticConvention(..))
import Repr.SemanticType (SemanticType(..))
import Repr.Attribute (Attribute(..))
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)
import Repr.AttributeType (AttributeType(..))

main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] do
  AttributeTypeSpec.spec
  AttributeSpec.spec
  describe "parseGroups" do
    it "parses groups" do
      let input = """
        groups:
          - id: network
            prefix: net
            brief: description
            attributes:
              - id: type
                type: string
                brief: description here
                examples: ["java.net.ConnectException", "OSError"]
        """
      parseGroups input `shouldEqual` (Right (
        Groups [(SemanticConvention { attributes: [(Definition { brief: "description here", examples: [], id: "type", samplingRelevant: false, tag: Nothing, type_: String })], brief: (Just "description"), deprecated: Nothing, events: [], extends: Nothing, id: "network", note: Nothing, prefix: (Just "net"), type_: Span })]))
