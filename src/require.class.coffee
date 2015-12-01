zipObject = require 'lodash.zipobject'
path = require 'path'

module.exports = class Require
	constructor: (modulesMap) ->
		map = @parseMosulesMap modulesMap
		packagesName = @makePackagesName map.packages
		nodeModulesName = @makeNodeModulesName map.fullPaths
		@collection = zipObject packagesName, nodeModulesName

	parseMosulesMap: (modulesMap) ->

		packagesList = []
		fullPathsList = []

		for modulePath, modules of modulesMap
			for one in modules
				packagesList.push one
				fullPathsList.push modulePath + one

		packages: packagesList
		fullPaths: fullPathsList

	makeNodeModulesName: (packagesPaths) ->
		for file in packagesPaths
			require path.resolve file

	makePackagesName: (packagesNames) ->
		packages = []
		one = (arr) -> if arr.length is 1 then yes
		exclusive = (arr) ->
			supportList = /(?:gulp|grunt|broccoli)/g
			if arr.join(' ').match(supportList) then yes
		concat = (part) -> part[0].toUpperCase() + part[1...]
		concatenation = (arr) ->
			name = ''
			for el, i in arr
				if i is 0 then name += el
				else name += concat el
			return name

		for file in packagesNames
			part = file.split /[-.]/g
			if one part
				packages.push part
			else if exclusive part
				packages.push concatenation part[1...]
			else if not exclusive part
				packages.push concatenation part

		return packages