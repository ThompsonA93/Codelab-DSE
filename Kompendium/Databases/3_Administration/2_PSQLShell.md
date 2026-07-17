# PSQL Shell

- [PSQL Shell](#psql-shell)
  - [Initializing the Connection](#initializing-the-connection)
    - [Authentication Methods (Password, Peer, Trust)](#authentication-methods-password-peer-trust)
    - [Specifying Host, Port, Database, and User](#specifying-host-port-database-and-user)
    - [Connection Troubleshooting](#connection-troubleshooting)
  - [PSQL Session Control](#psql-session-control)
    - [`\?` (General Help)](#-general-help)
    - [`\h` (SQL Command Syntax Help)](#h-sql-command-syntax-help)
    - [`\c` (Change connection)](#c-change-connection)
    - [`\set` (Display current settings)](#set-display-current-settings)
    - [`\conninfo` (Display current connection info)](#conninfo-display-current-connection-info)
  - [Database Object Inspection](#database-object-inspection)
    - [`\l` (List Databases)](#l-list-databases)
    - [`\d` (Describe Object: Table, View, Index)](#d-describe-object-table-view-index)
    - [`\dn` (List Schemas)](#dn-list-schemas)
    - [`\dt` (List Tables in Schema)](#dt-list-tables-in-schema)
    - [`\du` (List Users/Roles)](#du-list-usersroles)
    - [`\di` (List indices)](#di-list-indices)
  - [I/O and Editing](#io-and-editing)
    - [`\e` (Edit Command Buffer)](#e-edit-command-buffer)
    - [`\g` (Execute Current Query)](#g-execute-current-query)
    - [`\i` (Execute File/Script)](#i-execute-filescript)
    - [`\o` (Redirect Query Output to File)](#o-redirect-query-output-to-file)
  - [Performance and Output Formatting](#performance-and-output-formatting)
    - [Displaying Timing and Execution Details (`\timing`)](#displaying-timing-and-execution-details-timing)
    - [Adjusting Output Format (`\pset`)](#adjusting-output-format-pset)
    - [`\x` (Toggle Expanded Display)](#x-toggle-expanded-display)
  - [Buld Data Transfer](#buld-data-transfer)
    - [Import/Export Data (`\copy`)](#importexport-data-copy)
  - [Shell Script Integration](#shell-script-integration)
    - [Creating Reusable Scripts (`.sql` files)](#creating-reusable-scripts-sql-files)
    - [Piping Data to and from PSQL (e.g., `psql < input.sql`)](#piping-data-to-and-from-psql-eg-psql--inputsql)
    - [Using PSQL Variables for Scripting](#using-psql-variables-for-scripting)



## Initializing the Connection
### Authentication Methods (Password, Peer, Trust)
### Specifying Host, Port, Database, and User

- Using Environment Variables (`PGHOST`, `PGUSER`, etc.)

### Connection Troubleshooting

- Common Connection Errors


## PSQL Session Control
### `\?` (General Help)
### `\h` (SQL Command Syntax Help)
### `\c` (Change connection)
### `\set` (Display current settings)
### `\conninfo` (Display current connection info)


## Database Object Inspection
### `\l` (List Databases)
### `\d` (Describe Object: Table, View, Index)
### `\dn` (List Schemas)
### `\dt` (List Tables in Schema)
### `\du` (List Users/Roles)
### `\di` (List indices)

## I/O and Editing
### `\e` (Edit Command Buffer)
### `\g` (Execute Current Query)
### `\i` (Execute File/Script)
### `\o` (Redirect Query Output to File)


## Performance and Output Formatting
### Displaying Timing and Execution Details (`\timing`)
### Adjusting Output Format (`\pset`)
### `\x` (Toggle Expanded Display)

## Buld Data Transfer
### Import/Export Data (`\copy`)

## Shell Script Integration
### Creating Reusable Scripts (`.sql` files)
### Piping Data to and from PSQL (e.g., `psql < input.sql`)
### Using PSQL Variables for Scripting