knex-migrate
============

A migration generator for the knex query builder. 

## Features

The knex generator interface is inspired from the rails migration generator, and if you are familiar with the latter, you should be immediately comfortable with this generator for knex. Migration files are output using CoffeScript.

## Syntax

`knex-migrate migration_name [column:type[:index]]` Will produce a migration name `YYYYMMDDHHmmSS_migration_name.coffee`. There are several special cases for migration_name which migrations will be automatically generated:
- `AddXXXtoYYY` and `RemoveXXXfromYYY`
    - Generate a change migration
    - Columns specified like `name:type` are automatically added to the migration
    - `name:type:index` will also add an index to the column if possible
- `CreateXXX`
    - Generates table named XXX
    - add columns as specified above
- `DropXXX`
    - Drop table XXX. If there are references associated with the table, be sure to modify the migration to clean those up.
- `AddXXXRefToYYY`
    - add xxx ref to yyy table
- `CreateJoinTableXXXYYY`
    - Create a join table for the tables XXX and YYY

## Examples

Create a table for books with a few fields.

```shell
knex-migrate create_user_table name:string:index password:string
```

Creates migration file `YYYYMMDDHHmmSS_create_user_table.coffee`:

```coffee-script
module.exports = 
  up: (knex, Promise) ->
    knex.schema.createTable 'user', (t) ->
      t.increments('id').primary()

      t.string('name').index()
      t.string('password')

      t.timestamps()
  down: (knex, Promise) ->
    knex.schema.dropTable 'user'
```


