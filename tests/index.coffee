
{ assert } = require "chai"

describe "auto-require", ->
  describe "Testing accesibility", ->

    $ = do require "../dist/index.js"

    it "express is accesible via $.express", ->
      assert.deepEqual $.express, require "express"
      
    it "browser-sync is accesible via $.browserSync", ->
      assert.deepEqual $.browserSync, require "browser-sync"
      
    it "andyet-express-auth is accesible via $.andyetExpressAuth", ->
      assert.deepEqual $.andyetExpressAuth, require "andyet-express-auth"
      
    it "gulp is accesible via $.gulp", ->
      assert.deepEqual $.gulp, require "gulp"
      
    it "gulp-plumber is accesible via $.plumber", ->
      assert.deepEqual $.plumber, require "gulp-plumber"
      
    it "gulp-inline-css is accesible via $.inlineCss", ->
      assert.deepEqual $.inlineCss, require "gulp-inline-css"
      
    it "grunt is accesible via $.grunt", ->
      assert.deepEqual $.grunt, require "grunt"
      
    it "grunt-load is accesible via $.load", ->
      assert.deepEqual $.load, require "grunt-load"
      
    it "grunt-closure-tools is accesible via $.closureTools", ->
      assert.deepEqual $.closureTools, require "grunt-closure-tools"
      
    it "broccoli is accesible via $.broccoli", ->
      assert.deepEqual $.broccoli, require "broccoli"
      
    it "broccoli-sass is accesible via $.sass", ->
      assert.deepEqual $.sass, require "broccoli-sass"
      
    it "broccoli-react-caching is accesible via $.reactCaching", ->
      assert.deepEqual $.reactCaching, require "broccoli-react-caching"
      
    it "broccoli-use-strict-remover is accesible via $.useStrictRemover", ->
      assert.deepEqual $.useStrictRemover, require "broccoli-use-strict-remover"
      
    it "broccoli-file-contents-to-json is accesible via $.fileContentsToJson", ->
      assert.deepEqual $.fileContentsToJson, require "broccoli-file-contents-to-json"
      
    it "run-sequence is accesible via $.runSequence", ->
      assert.deepEqual $.runSequence, require "run-sequence"


  describe "Testing only() function", ->

    $ = require("../dist/index.js")
      only: [
        "gulp"
        "gulp-plumber"
        "gulp-inline-css"
      ]

    it "gulp is accesible via $.gulp", ->
      assert.deepEqual $.gulp, require "gulp"
      
    it "gulp-plumber is accesible via $.plumber", ->
      assert.deepEqual $.plumber, require "gulp-plumber"
      
    it "gulp-inline-css is accesible via $.inlineCss", ->
      assert.deepEqual $.inlineCss, require "gulp-inline-css"
      
    it "run-sequence is undefined", ->
      assert.equal $.runSequence, undefined

    
  describe "Testing without() function", ->

    $ = require("../dist/index.js")
      without: [
        "gulp-inline-css"
      ]

    it "gulp is accesible via $.gulp", ->
      assert.deepEqual $.gulp, require "gulp"
      
    it "gulp-inline-css is undefined", ->
      assert.equal $.inlineCss, undefined

    
  describe "Testing search() function without node_modules", ->

    $ = require("../dist/index.js")
      search: [
        "./test/my-modules/"
      ]

    it "super-smile is accesible via $.superSmile", ->
      assert.deepEqual $.superSmile, require "./my-modules/super-smile/"

    it "gulp is undefined", ->
      assert.equal $.gulp, undefined
      
    
  describe "Testing search() function with node_modules", ->

    $ = require("../dist/index.js")
      search: [
        "./test/my-modules/"
        "./node_modules/"
      ]

    it "big-wall is accesible via $.bigWall", ->
      assert.deepEqual $.bigWall, require "./my-modules/big-wall/"

    it "gulp is accesible via $.gulp", ->
      assert.deepEqual $.gulp, require "gulp"