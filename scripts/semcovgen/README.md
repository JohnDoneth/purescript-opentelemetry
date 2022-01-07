# Semantic Convention Generator

The semantic conventions spec defines common tracing attributes. Some of these
attributes. We use the schema definintions from the [opentelemetry-specification](https://github.com/open-telemetry/opentelemetry-specification)
repository to generate well-typed and documented PureScript code.

The schema definitions are in YAML and are processed by this tool, which then
generates PureScript source files containing the semantic convention types.

## Example

Some of the attributes like `db.system` [mentioned here](https://github.com/open-telemetry/opentelemetry-specification/blob/3e380e249f60c3a5f68746f5e84d10195ba41a79/specification/trace/semantic_conventions/database.md#semantic-conventions-for-database-client-calls) are defined as having a set of values,
we can generates PureScript types to prevent issues with typos and have nice
documentation for each possible value.

```purescript
data DbSystem =
  -- Some other SQL database. Fallback only. See notes.
  OTHER_SQL |
  -- Microsoft SQL Server.
  MSSQL |
  -- MySQL.
  MYSQL
  -- Many others omitted for this example

instance Show DbSystem where
    show OTHER_SQL = "other_sql"
    show MSSQL = "mssql"
    show MYSQL = "mysql"
    -- Many others omitted for this example
```
