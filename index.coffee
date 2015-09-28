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
		buildTool = (arr) -> if arr[0] is 'gulp' or arr[0] is 'grunt' or arr[0] is 'broccoli' then yes
		for part in files
			part = part.split '-'
			if one part
				packages.push part[0]
			else if buildTool part
				if two part
					packages.push part[1]
				else if three part
					packages.push "#{part[1]}#{part[2][0].toUpperCase()}#{part[2][1...]}"
				else if four part
					packages.push "#{part[1]}#{part[2][0].toUpperCase()}#{part[2][1...]}#{part[3][0].toUpperCase()}#{part[3][1...]}"				
				else if five part
					packages.push "#{part[1]}#{part[2][0].toUpperCase()}#{part[2][1...]}#{part[3][0].toUpperCase()}#{part[3][1...]}#{part[4][0].toUpperCase()}#{part[4][1...]}"
			else if not buildTool part
				if two part
					packages.push "#{part[0]}#{part[1][0].toUpperCase()}#{part[1][1...]}"
				else if three part
					packages.push "#{part[0]}#{part[1][0].toUpperCase()}#{part[1][1...]}#{part[2][0].toUpperCase()}#{part[2][1...]}"
				else if four part
					packages.push "#{part[0]}#{part[1][0].toUpperCase()}#{part[1][1...]}#{part[2][0].toUpperCase()}#{part[2][1...]}#{part[3][0].toUpperCase()}#{part[3][1...]}"				
		return packages

	makeNodeModulesName: (files) -> 
		require file for file in files

	makeCollection: (a, b) ->
		zipObject = require 'lodash.zipobject'
		@collection = zipObject a, b

$ = new Require

module.exports = $.collection