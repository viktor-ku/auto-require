
var assert = require('chai').assert;

describe("Auto-require", function() {
	describe('Testing accesibility', function() {
		var $ = require('../dist/index.js')();
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
		it('broccoli is accesible via $.broccoli', function() {
			assert.deepEqual($.broccoli, require('broccoli'));
		});
		it('broccoli-sass is accesible via $.sass', function() {
			assert.deepEqual($.sass, require('broccoli-sass'));
		});
		it('broccoli-react-caching is accesible via $.reactCaching', function() {
			assert.deepEqual($.reactCaching, require('broccoli-react-caching'));
		});
		it('broccoli-use-strict-remover is accesible via $.useStrictRemover', function() {
			assert.deepEqual($.useStrictRemover, require('broccoli-use-strict-remover'));
		});
		it('broccoli-file-contents-to-json is accesible via $.fileContentsToJson', function() {
			assert.deepEqual($.fileContentsToJson, require('broccoli-file-contents-to-json'));
		});	
		it('run-sequence is accesible via $.runSequence', function() {
			assert.deepEqual($.runSequence, require('run-sequence'));
		});	
	});
	describe('Testing only() function', function() {
		var $ = require('../dist/index.js')({
			only: ['gulp', 'gulp-plumber', 'gulp-inline-css']
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
		it('run-sequence is undefined', function() {
			assert.equal($.runSequence, undefined);
		});	
	});
	describe('Testing without() function', function() {
		var $ = require('../dist/index.js')({
			without: ['gulp-inline-css']
		});
		it('gulp is accesible via $.gulp', function() {
			assert.deepEqual($.gulp, require('gulp'));
		});
		it('gulp-inline-css is undefined', function() {
			assert.equal($.inlineCss, undefined);
		});	
	});
	describe('Testing search() function without node_modules', function() {
		var $ = require('../dist/index.js')({
			search: ['./my-modules/']
		});
		it('super-smile is accesible via $.superSmile', function() {
			assert.deepEqual($.superSmile, require('./my-modules/super-smile'));
		});
		it('gulp is undefined', function() {
			assert.equal($.gulp, undefined);
		});
	});
	describe('Testing search() function with node_modules', function() {
		var $ = require('../dist/index.js')({
			search: ['./my-modules/', './node_modules/']
		});
		it('big-wall is accesible via $.bigWall', function() {
			assert.deepEqual($.bigWall, require('./my-modules/big-wall'));
		});
		it('gulp is accesible via $.gulp', function() {
			assert.deepEqual($.gulp, require('gulp'));
		});
	});
});