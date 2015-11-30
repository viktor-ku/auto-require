fs = require 'fs'
path = require 'path'
valid = require './valid'
color = require 'chalk'
Require = require './require.class'
zipObject = require 'lodash.zipobject'

Array::drop = require './deleteFromArray'

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

	for onePath in search
		folders.push fs.readdirSync path.resolve onePath

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
	only: ['grunt', 'gulp']