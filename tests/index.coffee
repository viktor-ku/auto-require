
{ assert } = require "chai"

$ = require "../src/index"

{ zipObject, contains, drop } = require "../src/helpers"
{ modulesMap, makePackagesName, parseModulesMap, makeNodeModulesName, one, exclusive, concatenation } = require "../src/reqr"

describe "Helpers", ->

  describe "zipObject()", ->

    it "['name'] and ['Viktor']\t => {name: 'Viktor'}", ->
      assert.deepEqual zipObject(["name"], ["Viktor"]), { name: "Viktor" }

    it "['age'] and [21, true]\t => {age: 21, additional: [true]}", ->
      assert.deepEqual zipObject(["age"], [21, on]), { age: 21, additional: [true] }

    it "['obj'] and [{ a: 1 }]\t => {obj: { a: 1 }}", ->
      assert.deepEqual zipObject(['obj'], [{ a: 1 }]), { obj: { a: 1 } }

  describe "drop()", ->

    it "drop([1, 2, 3], [1]) => [2, 3]", ->
      assert.deepEqual drop([1, 2, 3], [1]), [2, 3]

    it "drop(['name', 'age'], ['name']) => ['age']", ->
      assert.deepEqual drop(["name", "age"], ["name"]), ["age"]

    it "drop(['name', 'age'], ['zip']) => ['name', 'age']", ->
      assert.deepEqual drop(["name", "age"], ["zip"]), ["name", "age"]

    it "drop([1, 2], [9, 8, 7, 6, 5]) => [1, 2]", ->
      assert.deepEqual drop([1, 2], [9, 8, 7, 6, 5]), [1, 2]

    it "drop([0, 1], [9, 8, 7, 6, 1]) => [0]", ->
      assert.deepEqual drop([0, 1], [9, 8, 7, 6, 1]), [0]

  describe "contains()", ->

    it "[1, 2, 3, 4] contains [2, 4] => [2, 4]", ->
      assert.deepEqual contains([1, 2, 3, 4], [2, 4]), [2, 4]

    it "['gulp', 'grunt', 'react'] contains ['gulp'] => ['gulp']", ->
      assert.deepEqual contains(["gulp", "grunt", "react"], ["gulp"]), ["gulp"]

describe "auto-require", ->

  describe "modulesMap()", ->

    it "Should be OK", ->

      assert.isOk modulesMap()

    it "Should return globaly as false", ->

      assert.deepEqual modulesMap().globaly, no

    it "Should return globaly as true", ->

      assert.deepEqual modulesMap({globaly: on}).globaly, on

    it "Should return only gulp in node_modules and be not global", ->

      assert.deepEqual modulesMap({only: "gulp"}), schema: { 'node_modules/': [ 'gulp' ] }, globaly: no

    it "Should return without all except chai in node_modules and be not global", ->

      assert.deepEqual modulesMap({without: ["gulp", "gulp-coffee", "gulp-jsbeautifier", "gulp-notify", "gulp-plumber", "coffee-script"]}), schema: { 'node_modules/': [ 'chai' ] }, globaly: no

  describe "$()", ->

    it "Should work", ->

      assert.isOk $
        search: ["node_modules/", "tests/my-modules/"]
        only: ["gulp", "coffee-script", "big-wall", "gulp-plumber"]
        without: ["gulp", "coffee-script", "big-wall"]
        globaly: on

    it "gulp should be accessible globaly", ->

      assert.isOk gulp

    it "bigWall should be accessible globaly (custom)", ->

      assert.isOk bigWall