
{ assert } = require "chai"

$ = require "../src/index"

{ zipObject, contains, drop } = require "../src/helpers"
{ reqr, modulesMap, makePackagesName, parseModulesMap, makeNodeModulesName, one, exclusive, concat, concatenation } = require "../src/reqr"

describe "Helpers", ->

  describe "zipObject()", ->

    it "['name'] and ['Viktor']\t => {name: 'Viktor'}", ->
      assert.deepEqual zipObject(["name"], ["Viktor"]), { name: "Viktor" }

    it "['age'] and [21, true]\t => {age: 21, additional: [true]}", ->
      assert.deepEqual zipObject(["age"], [21, on]), { age: 21, additional: [true] }

    it "['obj'] and [{ a: 1 }]\t => {obj: { a: 1 }}", ->
      assert.deepEqual zipObject(['obj'], [{ a: 1 }]), { obj: { a: 1 } }

  describe "drop()", ->

    it "[1, 2, 3].drop(1) => [1, 2]", ->
      assert.deepEqual drop([1, 2, 3], 1), [2, 3]

    it "['name', 'age'].drop('name') => ['age']", ->
      assert.deepEqual drop(["name", "age"], "name"), ["age"]

  describe "contains()", ->

    it "[1, 2, 3, 4] contains [2, 4] => [2, 4]", ->
      assert.deepEqual contains([1, 2, 3, 4], [2, 4]), [2, 4]

    it "['gulp', 'grunt', 'react'] contains ['gulp'] => ['gulp']", ->
      assert.deepEqual contains(["gulp", "grunt", "react"], ["gulp"]), ["gulp"]