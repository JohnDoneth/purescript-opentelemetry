module Codegen (generateModule) where

import Codegen.Module
import Data.Maybe
import Data.String.Extra
import Data.String.Pattern
import Prelude

import Codegen.Expression (Data(..), Expression(..))
import Codegen.Function (Function(..))
import Codegen.Import (Import(..))
import Codegen.ModuleName (ModuleName(..))
import Data.Array (concat, foldl)
import Data.Map (Map)
import Data.Map as Map
import Data.String (split)
import Effect.Exception (error)
import Repr.Attribute (Attribute(..))
import Repr.AttributeType (AttributeType(..), EnumMember(..), toPureScriptExpr, toPureScriptType)
import Repr.Groups (Groups(..))
import Repr.SemanticConvention (SemanticConvention(..))
import Data.Tuple

generateModule :: Groups -> Module
generateModule groups =
  Module
    { name: ModuleName [ "SemanticConvention" ]
    , imports:
        [ Import [ "Prelude" ]
        , Import [ "Data", "Pair" ]
        ]
    ,
      --expressions: [],
      expressions: groupsToExpressions groups <> enumsToExpressions groups
    }

groupsToExpressions :: Groups -> (Array Expression)
groupsToExpressions (Groups groups) = concat $ map groupToExpr groups
  where
  groupToExpr :: SemanticConvention -> Array Expression
  groupToExpr (SemanticConvention semconv) = map (\attribute -> generateExpression (SemanticConvention semconv) attribute) semconv.attributes

generateExpression :: SemanticConvention -> Attribute -> Expression
generateExpression (SemanticConvention semconv) (Definition attr) =
  FunctionExpr $ Function
    { doc: [ attr.brief ]
    , name: expressionName (SemanticConvention semconv) (Definition attr)
    , type_: [ toPureScriptType attr.type_, "Pair String" ]
    , args: [ "input" ]
    , value: "Pair \"" <> semconv.id <> "." <> attr.id <> "\" (show input)"
    }

generateExpression (SemanticConvention _semconv) (Reference _attr) =
  FunctionExpr $ Function { doc: [], name: "", type_: [], args: [], value: "" }

expressionName :: SemanticConvention -> Attribute -> String
expressionName (SemanticConvention semconv) (Definition attr) = camelCase semconv.id <> pascalCase attr.id
expressionName (SemanticConvention semconv) (Reference _attr) = camelCase semconv.id <> ""

-- | a.b.c -> ["a", "b", "c"]
-- dottedSplit :: String -> Array String
-- dottedSplit input = split (Pattern ".") input

-- splitToName :: Array String -> String
-- splitToName input = foldl (\acc i -> case acc of
--     "" -> i
--     _ -> acc <> upperCaseFirst i) "" input

enumsToExpressions :: Groups -> Array Expression
enumsToExpressions (Groups groups) = attributetoExprs $ attrToAttrType $ semconvToAttributes groups
  where
  -- TODO: ! Replace this whole mess with composable lenses !
  semconvToAttributes :: Array SemanticConvention -> Array Attribute
  semconvToAttributes semconvs = concat $ map (\(SemanticConvention semconv) -> semconv.attributes) semconvs

  attrToAttrType :: Array Attribute -> Array AttributeType
  attrToAttrType expressions = concat $ map attrToType expressions

  attrToType :: Attribute -> Array AttributeType
  attrToType (Definition { type_: type_ }) = [ type_ ]
  attrToType _ = []

  attributetoExprs :: Array AttributeType -> Array Expression
  attributetoExprs types = concat $ map attrTypeToExpr types

  attrTypeToExpr :: AttributeType -> Array Expression
  attrTypeToExpr (Enum enum) =
    [ DataExpr $ Data
        { name: enum.id
        , variants: (map pascalCase $ enumMembers enum.members) <> customEnumMember enum.id enum.allowCustomValues
        }
    ]
  attrTypeToExpr _ = []

  customEnumMember :: String -> Boolean -> Array String
  customEnumMember id true = [ "Custom" <> pascalCase id <> " String" ]
  customEnumMember _ false = []

  enumMembers :: Map String EnumMember -> Array String
  enumMembers input = map (\(EnumMember member) -> member.value) $ map (\(Tuple _ b) -> b) $ Map.toUnfoldable $ input