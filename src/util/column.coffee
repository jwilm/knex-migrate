types = 
  "integer"   : "integer"
  "text"      : "text"
  "string"    : "string"
  "float"     : "float"
  "decimal"   : "decimal"
  "boolean"   : "boolean"
  "date"      : "date"
  "datetime"  : "dateTime"
  "time"      : "time"
  "timestamp" : "timestamp"
  "binary"    : "binary"
  "enum"      : "enum"
  "json"      : "json"
  "uuid"      : "uuid"
  "references": "references"

indices =
  "index" : "index"
  "unique": "unique"

r_parse_col = /^([a-zA-Z_-]+):([a-zA-Z_-]+)(:(?:(unique|index)))?$/i

class Column
  constructor: (col) ->
    # [nope, @name, @type, @index] = r_parse_col.exec(col)
    [nope, @name, @type, nope, @index] = r_parse_col.exec(col)

    unless @name? and @type? and types[@type.toLowerCase()]?
      throw new Error("#{col} is invalid")

  toAddString: ->
    # Base column definition
    str = "t.#{types[@type.toLowerCase()]}('#{@name}')"
    # Also create index if requested
    str += ".#{indices[@index.toLowerCase()]}()" if @index?
    str

module.exports = Column
