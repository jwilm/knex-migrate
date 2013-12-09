Parser = require '../src/cli/parser'
assert = require 'assert'

describe 'CLI Parser', ->
  describe 'construction', ->
    it 'should throw an error when options are invalid', ->
      assert.throws ->
        new Parser 123
      assert.throws ->
        new Parser 'asdf'
      assert.throws ->
        new Parser {i_am: 'invalid'}
      assert.throws ->
        new Parser ['coffee', 'script', 'not_a_task', 'random', 'options']
    it 'should not throw errors with valid options', ->
      assert.doesNotThrow ->
        new Parser ['coffee', 'script', 'generate', 'stuff']
      assert.doesNotThrow ->
        new Parser ['coffee', 'script', 'run']

  describe '#task', ->
    it 'should return the task to perform', ->
      parser = new Parser ['coffee', 'script', 'generate', 'table']
      assert.equal parser.task(), 'generate'

  describe '#options', ->
    it 'should return the remaining options following the task', ->
      args = ['coffee', 'script', 'generate', 'CreateUserTable',
              'name:string:index', 'email:string']
      parser = new Parser args
      assert.deepEqual parser.options(), args.slice(3, args.length)

  describe '#help', ->
    it 'should return a help string', ->
      assert.ok /usage/i.test Parser.help()
