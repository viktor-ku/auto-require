fs = require 'fs'
path = require 'path'
valid = require './valid'
color = require 'chalk'
Require = require './require.class'
zipObject = require 'lodash.zipobject'

Array::drop = require './deleteFromArray'

module.exports = (options) ->

	if valid options.search
		{search} = options
	else
		search = ['./node_modules/']

	folders = (fs.readdirSync path.resolve one for one in search)

	if valid options.only
		{only} = options
	else if not valid options.only
		if valid options.without
			{without} = options

	modules = zipObject search, folders

	for k, v of modules
		v.drop '.bin'
		v.drop 'auto-require'
		if without
			v.drop one for one in without
		if only
			for one in only
				if v isnt one
					v.splice /[a-z-_.]+/g, 1
				else
					continue

	console.log modules

module.exports
	search: ['./node_modules/', './test/my-modules/']
	without: ['gulp', 'run-sequence']
	only: ['grunt']