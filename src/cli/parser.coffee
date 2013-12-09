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
    [prog, script, @_task, @_options...] = @args
    unless options_map[@_task]?
      throw new Error 'Cannot Perform Task'

  task: () ->
    @_task

  options: () ->
    @_options

Parser.help = () ->
  usage = """
          usage:
          knex-migrate <task> [options]

          tasks:\n
          """

  max_task_len = 0
  for key of options_map
    max_task_len = key.length if key.length > max_task_len

  for key, val of options_map
    usage += "    #{key}:"
    usage += (new Array(max_task_len - key.length + 2)).join(' ') + " #{val}\n"

  usage


module.exports = Parser
