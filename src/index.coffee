fs = require 'fs'
zipObject = require 'lodash.zipobject'

class Require
	constructor: (packages) ->
		packagesName = @makePackagesName packages
		nodeModulesName = @makeNodeModulesName packages
		@makeCollection packagesName, nodeModulesName

	makeNodeModulesName: (files) -> 
		require file for file in files

	makeCollection: (a, b) ->
		@collection = zipObject a, b

	makePackagesName: (files) ->
		packages = []
		one = (arr) -> if arr.length is 1 then yes
		exclusive = (arr) ->
			exclusiveList = /gulp|grunt|broccoli|jquery/g
			if arr.join(' ').match(exclusiveList) then yes
		concat = (part) -> part[0].toUpperCase() + part[1...]
		concatenation = (arr) ->
			name = ''
			for el, i in arr
				if i is 0 then name += el
				else name += concat el
			return name
		for file in files
			part = file.split '-'
			if one part
				packages.push part[0]
			else if exclusive part
				packages.push concatenation part[1...]
			else if not exclusive part
				packages.push concatenation part
		return packages

module.exports = (only) ->
	if only? and only isnt ''
		modules = only
	else
		modules = fs.readdirSync "./node_modules/"
		if modules.indexOf('.bin') >= 0
			modules.splice modules.indexOf('.bin'), 1

	that = new Require modules
	return that.collection