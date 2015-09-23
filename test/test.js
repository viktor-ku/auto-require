
var assert = require("assert");

var sum = function(a, b) {
	return a + b;
};

describe('sum()', function() {
	it("sum(1, 1) is equal to 2", function() {
		assert.equal(sum(1, 1), 2);
	});
	it("sum(10, 54) is equal to 64", function() {
		assert.equal(sum(10, 54), 64);
	});
});