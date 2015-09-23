
fs = require 'fs'
_ = require 'lodash'

makePackagesName = (files) ->
	packages = []
	for file in files
		file = file.split '-'
		if file.length > 1 and file[0].match 'gulp'
			packages.push file[1]
		else if file.length > 1 and not file[0].match 'gulp'
			packages.push "#{file[0]}#{file[1][0].toUpperCase()}#{file[1][1...]}"
		else if file.length is 1
			packages.push file[0]
	return packages

makeNodeModulesName = (files) -> 
	require file for file in files

makeCollector = (cols, rows) -> 
	_.zipObject cols, rows

quest = fs.readdirSync('./node_modules')[1...]

packagesName = makePackagesName quest
nodeModulesName = makeNodeModulesName quest
module.exports = makeCollector packagesName, nodeModulesName