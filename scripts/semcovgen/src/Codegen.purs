module Codegen (generateModule) where

import Codegen.Module
import Data.String.Extra
import Data.String.Pattern
import Prelude

import Codegen.Expression (Expression(..))
import Codegen.Function (Function(..))
import Codegen.Import (Import(..))
import Codegen.ModuleName (ModuleName(..))
import Data.Array (concat, foldl)
import Data.String (split)
import Effect.Exception (error)
import Repr.Attribute (Attribute(..))
import Repr.Groups (Groups(..))
import Repr.SemanticConvention (SemanticConvention(..))

generateModule :: Groups -> Module
generateModule groups =
    Module {
        name: ModuleName ["SemanticConvention"],
        imports: [Import ["Prelude"], Import ["Data", "Pair"]],
        --expressions: [],
        expressions: concat $ groupsToExpressions groups
    }


groupsToExpressions :: Groups -> Array (Array Expression)
groupsToExpressions (Groups groups) = map groupToExpr groups
    where 
        groupToExpr :: SemanticConvention -> Array Expression
        groupToExpr (SemanticConvention semconv) = map (\attribute -> generateExpression (SemanticConvention semconv) attribute) semconv.attributes


generateExpression :: SemanticConvention -> Attribute -> Expression

generateExpression (SemanticConvention semconv) (Definition attr) =
    FunctionExpr $ Function { doc: [attr.brief], name: camelCase semconv.id <> pascalCase attr.id, type_: ["String", "Pair String"], args: ["input"], value: "Pair \"" <> semconv.id <> "." <> attr.id <> "\" input" }

generateExpression (SemanticConvention semconv) (Reference attr) =
    FunctionExpr $ Function { doc: [], name: "", type_: [], args: [], value: "" }


-- | a.b.c -> ["a", "b", "c"]
dottedSplit :: String -> Array String
dottedSplit input = split (Pattern ".") input

splitToName :: Array String -> String
splitToName input = foldl (\acc i -> case acc of
    "" -> i
    _ -> acc <> upperCaseFirst i) "" input

combined :: String -> String
combined input = splitToName $ dottedSplit input