options_map =
  "generate" : "create a migration"
  "run"      : "run a migration"
  "rollback" : "rollback a migration"
  "status"   : "migration status"

class Parser
  constructor: (@args) ->
    unless @args instanceof Array
      throw new Error 'Parser requires string array'

    @parse()

  parse: () ->
    [prog, script, @_task, options...] = @args
    unless options_map[@_task]?
      throw new Error 'Cannot Perform Task'

  task: () ->
    @_task

  help: () ->
    usage = """
            knex-migrate usage:
            knex-migrate <task> [options]

            tasks
            """

    for key, val of options_map
      usage += "  #{key}: #{val}\n"

    usage

module.exports = Parser
