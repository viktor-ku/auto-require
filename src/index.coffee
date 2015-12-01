fs = require 'fs'
path = require 'path'
valid = require './valid'
color = require 'chalk'
Require = require './require.class'
zipObject = require 'lodash.zipobject'

Array::drop = require './deleteFromArray'
Array::drain = require './drainArray'

module.exports = (options) ->

	folders = []
	only = null
	without = null
	search = ['./node_modules/']

	if valid options.search
		{search} = options

	if valid options.only
		{only} = options
	else if not valid options.only
		if valid options.without
			{without} = options

	# search for these in paths
	# and push results


	for onePath in search
		content = fs.readdirSync path.resolve onePath
		if only
			arr = []
			for one in content
				for onlyModule in only
					if one is onlyModule
						arr.push one
			content = only
		folders.push arr

	for moduleGroups in folders
		if without
			for one in without
				moduleGroups.drop one
		for oneModule in moduleGroups
			if oneModule is '.bin' or oneModule is 'auto-require'
				moduleGroups.drop oneModule

	modulesMap = zipObject search, folders

	console.log modulesMap

module.exports
	search: ['./node_modules/', './test/my-modules/']
	without: ['gulp', 'run-sequence', 'chalk']
	only: ['grunt', 'gulp', 'big-wall']