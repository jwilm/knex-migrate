assert = require 'assert'
Column = require '../../src/util/column'

describe 'Command', ->

  it 'should throw an error when invoked incorrectly', ->
    assert.throws ->
      new Column()

  it 'should be valid with correct args', ->
    args = """
            user:string:index user:string email_address:string
            long_column_name_weee:float string:string
            """.replace('\n', ' ').split(' ')

    for arg in args
      assert.doesNotThrow ->
        new Column arg

  describe '#toAddString', ->
    it 'should create valid knex table add column code', ->
      adds =
        "user:string:index": "t.string('user').index()"
        "user:string": "t.string('user')"
        "thing_with_lodash:float": "t.float('thing_with_lodash')"
        "string:string": "t.string('string')"

      for col, code of adds
        assert.equal new Column(col).toAddString(), code
