-- DO NOT EDIT, this is an Auto-generated file
module OpenTelemetry.SemanticConvention.AWS.LAMBDA where

import Prelude
import Data.Pair

-- |
-- | The full invoked ARN as provided on the `Context` passed to the function (`Lambda-Runtime-Invoked-Function-Arn` header on the `/runtime/invocation/next` applicable).
-- |
-- | Note: This may be different from `faas.id` if an alias is involved.
-- |
invokedArn :: String -> Pair String
invokedArn input = Pair "aws.lambda.invoked_arn" input

dbSystem :: DbSystem -> Pair String
dbSystem input = Pair "db.system" (show input)

-- |
-- | An identifier for the database management system (DBMS) product being used. See below for a list of well-known identifiers.
-- | 
-- | - `OTHER_SQL` Some other SQL database. Fallback only. See notes.
-- | - `MSSQL` Microsoft SQL Server. 
-- | - `MYSQL` MySQL. 
-- | 
data DbSystem
  =
    -- Some other SQL database. Fallback only. See notes.
    OTHER_SQL
  |
    -- Microsoft SQL Server. 
    MSSQL
  |
    -- MySQL. 
    MYSQL

instance showDbSystem :: Show DbSystem where
  show OTHER_SQL = "other_sql"
  show MSSQL = "mssql"
  show MYSQL = "mysql"