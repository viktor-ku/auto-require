fs = require 'fs'
zipObject = require 'lodash.zipobject'

class Require
	constructor: ->		
		@quest = fs.readdirSync('./node_modules')[1...]
		@packagesName = @makePackagesName @quest
		@nodeModulesName = @makeNodeModulesName @quest
		@makeCollection @packagesName, @nodeModulesName

	makePackagesName: (files) ->
		packages = []
		one = (arr) -> if arr.length is 1 then yes
		two = (arr) -> if arr.length is 2 then yes
		three = (arr) -> if arr.length is 3 then yes
		buildTool = (arr) -> if arr[0] is 'gulp' or arr[0] is 'grunt' then yes
		for part in files
			part = part.split '-'
			if one part
				packages.push part[0]
			else if ((one part) or (two part)) and buildTool part
				packages.push part[1]
			else if (three part) and buildTool part
				packages.push "#{part[1]}#{part[2][0].toUpperCase()}#{part[2][1...]}"
			else if (two part) and not buildTool part
				packages.push "#{part[0]}#{part[1][0].toUpperCase()}#{part[1][1...]}"
			else if (three part) and not buildTool part
				packages.push "#{part[0]}#{part[1][0].toUpperCase()}#{part[1][1...]}#{part[2][0].toUpperCase()}#{part[2][1...]}"
		return packages

	makeNodeModulesName: (files) -> 
		require file for file in files

	makeCollection: (a, b) ->
		@collection = zipObject a, b

$ = new Require

module.exports = $.collection