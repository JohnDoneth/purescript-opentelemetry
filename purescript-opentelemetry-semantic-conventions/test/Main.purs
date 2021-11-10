module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console (log, logShow)

import OpenTelemetry.SemanticAttributes

main :: Effect Unit
main = do
  -- https://github.com/open-telemetry/opentelemetry-specification/blob/main/semantic_conventions/trace/database.yaml
  logShow $ parseGroup """
  id: db
  prefix: db
  brief: >
    This document defines the attributes used to perform database client calls.
  span_kind: client
  attributes:
    - id: system
      tag: connection-level
      brief: An identifier for the database management system (DBMS) product being used. See below for a list of well-known identifiers.
      required: always
      type:
        allow_custom_values: true
        members:
          - id: other_sql
            value: 'other_sql'
            brief: 'Some other SQL database. Fallback only. See notes.'
          - id: mssql
            value: 'mssql'
            brief: 'Microsoft SQL Server'
          - id: mysql
            value: 'mysql'
            brief: 'MySQL'
          - id: oracle
            value: 'oracle'
            brief: 'Oracle Database'
          - id: db2
            value: 'db2'
            brief: 'IBM Db2'
          - id: postgresql
            value: 'postgresql'
            brief: 'PostgreSQL'
          - id: redshift
            value: 'redshift'
            brief: 'Amazon Redshift'
          - id: hive
            value: 'hive'
            brief: 'Apache Hive'
          - id: cloudscape
            value: 'cloudscape'
            brief: 'Cloudscape'
          - id: hsqldb
            value: 'hsqldb'
            brief: 'HyperSQL DataBase'
          - id: progress
            value: 'progress'
            brief: 'Progress Database'
          - id: maxdb
            value: 'maxdb'
            brief: 'SAP MaxDB'
          - id: hanadb
            value: 'hanadb'
            brief: 'SAP HANA'
          - id: ingres
            value: 'ingres'
            brief: 'Ingres'
          - id: firstsql
            value: 'firstsql'
            brief: 'FirstSQL'
          - id: edb
            value: 'edb'
            brief: 'EnterpriseDB'
          - id: cache
            value: 'cache'
            brief: 'InterSystems Caché'
          - id: adabas
            value: 'adabas'
            brief: 'Adabas (Adaptable Database System)'
          - id: firebird
            value: 'firebird'
            brief: 'Firebird'
          - id: derby
            value: 'derby'
            brief: 'Apache Derby'
          - id: filemaker
            value: 'filemaker'
            brief: 'FileMaker'
          - id: informix
            value: 'informix'
            brief: 'Informix'
          - id: instantdb
            value: 'instantdb'
            brief: 'InstantDB'
          - id: interbase
            value: 'interbase'
            brief: 'InterBase'
          - id: mariadb
            value: 'mariadb'
            brief: 'MariaDB'
          - id: netezza
            value: 'netezza'
            brief: 'Netezza'
          - id: pervasive
            value: 'pervasive'
            brief: 'Pervasive PSQL'
          - id: pointbase
            value: 'pointbase'
            brief: 'PointBase'
          - id: sqlite
            value: 'sqlite'
            brief: 'SQLite'
          - id: sybase
            value: 'sybase'
            brief: 'Sybase'
          - id: teradata
            value: 'teradata'
            brief: 'Teradata'
          - id: vertica
            value: 'vertica'
            brief: 'Vertica'
          - id: h2
            value: 'h2'
            brief: 'H2'
          - id: coldfusion
            value: 'coldfusion'
            brief: 'ColdFusion IMQ'
          - id: cassandra
            value: 'cassandra'
            brief: 'Apache Cassandra'
          - id: hbase
            value: 'hbase'
            brief: 'Apache HBase'
          - id: mongodb
            value: 'mongodb'
            brief: 'MongoDB'
          - id: redis
            value: 'redis'
            brief: 'Redis'
          - id: couchbase
            value: 'couchbase'
            brief: 'Couchbase'
          - id: couchdb
            value: 'couchdb'
            brief: 'CouchDB'
          - id: cosmosdb
            value: 'cosmosdb'
            brief: 'Microsoft Azure Cosmos DB'
          - id: dynamodb
            value: 'dynamodb'
            brief: 'Amazon DynamoDB'
          - id: neo4j
            value: 'neo4j'
            brief: 'Neo4j'
          - id: geode
            value: 'geode'
            brief: 'Apache Geode'
          - id: elasticsearch
            value: 'elasticsearch'
            brief: 'Elasticsearch'
          - id: memcached
            value: 'memcached'
            brief: 'Memcached'
          - id: cockroachdb
            value: 'cockroachdb'
            brief: 'CockroachDB'
    - id: connection_string
      tag: connection-level
      type: string
      brief: >
        The connection string used to connect to the database.
        It is recommended to remove embedded credentials.
      examples: 'Server=(localdb)\v11.0;Integrated Security=true;'
    - id: user
      tag: connection-level
      type: string
      brief: >
        Username for accessing the database.
      examples: ['readonly_user', 'reporting_user']
    - id: jdbc.driver_classname
      tag: connection-level-tech-specific
      type: string
      brief: >
        The fully-qualified class name of the [Java Database Connectivity (JDBC)](https://docs.oracle.com/javase/8/docs/technotes/guides/jdbc/) driver used to connect.
      examples: ['org.postgresql.Driver', 'com.microsoft.sqlserver.jdbc.SQLServerDriver']
    - id: name
      tag: call-level
      type: string
      required:
        conditional: Required, if applicable.
      brief: >
        This attribute is used to report the name of the database being accessed.
        For commands that switch the database, this should be set to the target database
        (even if the command fails).
      note: >
        In some SQL databases, the database name to be used is called "schema name".
        In case there are multiple layers that could be considered for database name
        (e.g. Oracle instance name and schema name),
        the database name to be used is the more specific layer (e.g. Oracle schema name).
      examples: [ 'customers', 'main' ]
    - id: statement
      tag: call-level
      type: string
      required:
        conditional: >
          Required if applicable and not explicitly disabled via instrumentation configuration.
      brief: >
        The database statement being executed.
      note: The value may be sanitized to exclude sensitive information.
      examples: ['SELECT * FROM wuser_table', 'SET mykey "WuValue"']
    - id: operation
      tag: call-level
      type: string
      required:
        conditional: Required, if `db.statement` is not applicable.
      brief: >
        The name of the operation being executed, e.g. the [MongoDB command name](https://docs.mongodb.com/manual/reference/command/#database-operations)
        such as `findAndModify`, or the SQL keyword.
      note: >
        When setting this to an SQL keyword, it is not recommended to
        attempt any client-side parsing of `db.statement` just to get this
        property, but it should be set if the operation name is provided by
        the library being instrumented.
        If the SQL statement has an ambiguous operation, or performs more
        than one operation, this value may be omitted.
      examples: ['findAndModify', 'HMSET', 'SELECT']
    - ref: net.peer.name
      tag: connection-level
      required:
        conditional: See below.
    - ref: net.peer.ip
      tag: connection-level
      required:
        conditional: See below.
    - ref: net.peer.port
      tag: connection-level
      required:
        conditional: Required if using a port other than the default port for this DBMS.
    - ref: net.transport
      tag: connection-level
      required:
        conditional: Recommended in general, required for in-process databases (`"inproc"`).
  constraints:
    - any_of:
        - 'net.peer.name'
        - 'net.peer.ip'
  """

