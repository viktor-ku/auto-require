
{ assert } = require "chai"

$ = require "../src/index"

{ zipObject } = require "../src/helpers"

describe "Helpers", ->

  describe "zipObject()", ->

    it "['name'] and ['Viktor']\t => {name: 'Viktor'}", ->
      assert.deepEqual zipObject(["name"], ["Viktor"]), { name: "Viktor" }

    it "['age'] and [21, true]\t => {age: 21, additional: [true]}", ->
      assert.deepEqual zipObject(["age"], [21, on]), { age: 21, additional: [true] }

    it "['obj'] and [{ a: 1 }]\t => {obj: { a: 1 }}", ->
      assert.deepEqual zipObject(['obj'], [{ a: 1 }]), { obj: { a: 1 } }

  describe "Array::drop()", ->

    it "[1, 2, 3].drop(1) => [1, 2]", ->
      assert.deepEqual [1, 2, 3].drop(1), [2, 3]

    it "['name', 'age'].drop('name') => ['age']", ->
      assert.deepEqual ["name", "age"].drop("name"), ["age"]