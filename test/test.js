
var assert = require('chai').assert;
var zipObject = require('lodash.zipobject');
var $ = require('../index.js');

describe("Auto-require", function() {
	it('express is accesible via $.express', function() {
		assert.deepEqual($.express, require('express'));
	});
	it('browser-sync is accesible via $.browserSync', function() {
		assert.deepEqual($.browserSync, require('browser-sync'));
	});
	it('andyet-express-auth is accesible via $.andyetExpressAuth', function() {
		assert.deepEqual($.andyetExpressAuth, require('andyet-express-auth'));
	});
	it('gulp is accesible via $.gulp', function() {
		assert.deepEqual($.gulp, require('gulp'));
	});
	it('gulp-plumber is accesible via $.plumber', function() {
		assert.deepEqual($.plumber, require('gulp-plumber'));
	});
	it('gulp-inline-css is accesible via $.inlineCss', function() {
		assert.deepEqual($.inlineCss, require('gulp-inline-css'));
	});
	it('grunt is accesible via $.grunt', function() {
		assert.deepEqual($.grunt, require('grunt'));
	});
	it('grunt-load is accesible via $.load', function() {
		assert.deepEqual($.load, require('grunt-load'));
	});
	it('grunt-closure-tools is accesible via $.closureTools', function() {
		assert.deepEqual($.closureTools, require('grunt-closure-tools'));
	});
});