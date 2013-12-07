assert = require 'assert'
MigrationBase = require '../../src/migration/base'

describe 'MigrationBase', ->
	before ->
    @migration = new MigrationBase()

  it 'should respond to file_prefix', ->
    assert.ok @migration.file_prefix

  describe 'skeleton', ->
    it 'should provide an up method', ->
      assert.ok /up:/.test @migration.skeleton("up")

    it 'should provide a down method', ->
      assert.ok /down:/.test @migration.skeleton("up")

    it 'should not contain \'undefined\' when arguments are not provided', ->
      assert.ok !(/undefined/.test @migration.skeleton("up"))

    it 'should throw an error when up is not provided', ->
      assert.throws @migration.skeleton, Error

    describe 'when down is not provided', ->
      it 'should throw Irreversible Migration', ->
        # This should probably eval the code returned from skeleton and
        # run the down error to prove it throws an error
        rerror = /throw new Error "Irreversible Migration"/i
        assert.ok rerror.test @migration.skeleton("up")
