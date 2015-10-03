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
		one = (arr) -> 		if arr.length is 1 then yes
		exclusive = (arr) ->
			exclusiveList = ['gulp', 'grunt', 'broccoli', 'jquery']
			if exclusiveList.join('').match(arr[0]) then yes
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

module.exports = do ->
	fs = require 'fs'
	allModules = fs.readdirSync('./node_modules')[1...]
	all = new Require allModules 
	all.collection

module.exports.only = (params) -> 
	only = new Require params
	only.collection