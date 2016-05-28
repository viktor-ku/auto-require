
{ assert } = require "chai"

$ = require "../src/index"

{ zipObject, valid } = require "../src/helpers"

describe "Helpers", ->

  describe "zipObject()", ->

    it "['name'] and ['Viktor'] should return {name: 'Viktor'}", ->
      assert.deepEqual zipObject(["name"], ["Viktor"]), { name: "Viktor" }

    it "['age'] and [21, true] should return {age: 21, additional: [true]}", ->
      assert.deepEqual zipObject(["age"], [21, on]), { age: 21, additional: [true] }