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
		two = (arr) -> 		if arr.length is 2 then yes
		three = (arr) -> 	if arr.length is 3 then yes
		four = (arr) -> 	if arr.length is 4 then yes
		five = (arr) -> 	if arr.length is 5 then yes
		exclusive = (arr) -> 
			exclusiveList = ['gulp', 'grunt', 'broccoli', 'jquery']
			if exclusiveList.join('').match(arr[0]) then yes
		concat = (part) -> part[0].toUpperCase() + part[1...]
		for part in files
			part = part.split '-'
			if one part
				packages.push part[0]
			else if exclusive part
				if two part
					packages.push part[1]
				else if three part
					packages.push part[1] + (concat part[2])
				else if four part
					packages.push part[1] + (concat part[2]) + (concat part[3])
				else if five part
					packages.push part[1] + (concat part[2]) + (concat part[3]) + (concat part[4])
			else if not exclusive part
				if two part
					packages.push part[0] + (concat part[1])
				else if three part
					packages.push part[0] + (concat part[1]) + (concat part[2])
				else if four part
					packages.push part[0] + (concat part[1]) + (concat part[2]) + (concat part[3])				
				else if five part
					packages.push part[0] + (concat part[1]) + (concat part[2]) + (concat part[3]) + (concat part[4])				
		return packages

module.exports = do ->
	fs = require 'fs'
	allModules = fs.readdirSync('./node_modules')[1...]
	all = new Require allModules 
	all.collection

module.exports.only = (params) -> 
	only = new Require params
	only.collection