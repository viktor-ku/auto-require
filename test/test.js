
var assert = require('chai').assert;
var _ = require('lodash');
var $ = require('../index.js');

var testTemplate = function(nodeModules, expectedObject) {
	var packageName = $.makePackagesName(nodeModules);
	var outputObject = _.zipObject(nodeModules, packageName)
	assert.deepEqual(outputObject, expectedObject);	
};

describe("Auto-require", function() {
	it('express should be express', function() {
		testTemplate(['express'], {'express':'express'});
	});
	it("browser-sync should be browserSync", function() {
		testTemplate(['browser-sync'], {'browser-sync':'browserSync'});
	});
	it('andyet-express-auth should be andyetExpressAuth', function() {
		testTemplate(['andyet-express-auth'], {'andyet-express-auth':'andyetExpressAuth'});
	});
	it("gulp should be gulp", function() {
		testTemplate(['gulp'], {'gulp':'gulp'});
	});
	it("gulp-plumber should be plumber", function() {
		testTemplate(['gulp-plumber'], {'gulp-plumber':'plumber'});
	});
	it("gulp-inline-css should be inlineCss", function() {
		testTemplate(['gulp-inline-css'], {'gulp-inline-css':'inlineCss'});
	});
	it('grunt should be grunt', function() {
		testTemplate(['grunt'], {'grunt':'grunt'});
	});
	it('grunt-shell should be shell', function() {
		testTemplate(['grunt-shell'], {'grunt-shell':'shell'});
	});
	it('grunt-conventional-changelog should be conventionalChangelog', function() {
		testTemplate(['grunt-conventional-changelog'], {'grunt-conventional-changelog':'conventionalChangelog'});
	});
});