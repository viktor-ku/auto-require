class Require
	constructor: ->		
		fs = require 'fs'
		quest = fs.readdirSync('./node_modules')[1...]
		packagesName = @makePackagesName quest
		nodeModulesName = @makeNodeModulesName quest
		@makeCollection packagesName, nodeModulesName

	makePackagesName: (files) ->
		packages = []
		one = (arr) -> 		if arr.length is 1 then yes
		two = (arr) -> 		if arr.length is 2 then yes
		three = (arr) -> 	if arr.length is 3 then yes
		four = (arr) -> 	if arr.length is 4 then yes
		five = (arr) -> 	if arr.length is 5 then yes
		exclusive = (arr) -> if arr[0] is 'gulp' or arr[0] is 'grunt' or arr[0] is 'broccoli' or arr[0] is 'jquery' then yes
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

	makeNodeModulesName: (files) -> 
		require file for file in files

	makeCollection: (a, b) ->
		zipObject = require 'lodash.zipobject'
		@collection = zipObject a, b

$ = new Require

module.exports = $.collection