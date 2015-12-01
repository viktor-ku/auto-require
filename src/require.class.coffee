zipObject = require 'lodash.zipobject'
path = require 'path'

module.exports = class Require
	constructor: (modulesMap, @supportList = /gulp|grunt|broccoli/g) ->
		map = @parseMosulesMap modulesMap
		packagesName = @makePackagesName packages
		nodeModulesName = @makeNodeModulesName packages
		@collection = zipObject packagesName, nodeModulesName

	parseMosulesMap: (modulesMap) ->
		packages: ->
			for path, modules of modulesMap
				console.log modules

		fullPaths: -> console.dir modulesMap

	makeNodeModulesName: (files) ->
		require file for file in files

	makePackagesName: (files) ->
		packages = []
		one = (arr) -> if arr.length is 1 then yes
		exclusive = (arr) ->
			if arr.join(';').match(@supportList) then yes
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