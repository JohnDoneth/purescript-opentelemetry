module Repr.AttributeTypeSpec where

import Prelude

import Data.Either (Either(..))
import Parsing (parse)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Repr.AttributeType (AttributeType(..), EnumMember(..))
import Data.Map as Map
import Data.Tuple

spec :: Spec Unit
spec = do
  describe "AttributeType" $ do
    it "string" $ do
      parse "string" `shouldEqual` Right String

    it "int" $ do
      parse "int" `shouldEqual` Right Int

    it "double" $ do
      parse "double" `shouldEqual` Right Double

    it "boolean" $ do
      parse "boolean" `shouldEqual` Right Boolean

    it "string array" $ do
      parse "string[]" `shouldEqual` Right StringArray

    it "int array" $ do
      parse "int[]" `shouldEqual` Right IntArray

    it "double array" $ do
      parse "double[]" `shouldEqual` Right DoubleArray

    it "boolean array" $ do
      parse "boolean[]" `shouldEqual` Right BooleanArray

    it "parses enums" $ do
      parse
        """
        allow_custom_values: true
        members:
          - id: other_sql
            value: 'other_sql'
            brief: 'Some other SQL database. Fallback only. See notes.'
          - id: mssql
            value: 'mssql'
            brief: 'Microsoft SQL Server'
        """ `shouldEqual`
        ( Right $ Enum
            { id: ""
            , allowCustomValues: true
            , members: Map.fromFoldable
                [ Tuple "other_sql"
                    ( EnumMember
                        { value: "other_sql"
                        , brief: "Some other SQL database. Fallback only. See notes."
                        }
                    )
                , Tuple "mssql"
                    ( EnumMember
                        { value: "mssql"
                        , brief: "Microsoft SQL Server"
                        }
                    )
                ]
            }
        )
