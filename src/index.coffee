fs = require 'fs'
path = require 'path'
valid = require './valid'
color = require 'chalk'
Require = require './require.class'
zipObject = require 'lodash.zipobject'

Array::drop = require './deleteFromArray'

module.exports = (options) ->

	folders = []

	if valid options.search
		{search} = options
	else
		search = ['./node_modules/']

	if valid options.only
		{only} = options
	else if not valid options.only
		if valid options.without
			{without} = options

	for onePath in search
		folders.push fs.readdirSync path.resolve onePath

	modules = zipObject search, folders

	for k, v of modules
		v.drop '.bin'
		v.drop 'auto-require'

	console.log modules

module.exports
	search: ['./node_modules/', './test/my-modules/']
	without: ['gulp', 'run-sequence']
	only: ['grunt']