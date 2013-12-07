class Migration
  constructor: ->
    
  file_prefix: ->
    now = new Date()
    "#{now.getFullYear()}#{now.getMonth()+1}#{now.getDate()}#{now.getHours()}" +
    "#{now.getMinutes()}#{now.getSeconds()}"

  skeleton: (up, down) ->
    down ||= "throw new Error \"Irreversible Migration\""
    throw new Error "must provide up action" unless up?
    """
    module.exports =
      up: (knex, Promise) ->
        #{up}
      down: (knex, Promise) ->
        #{down}

    """

module.exports = Migration
