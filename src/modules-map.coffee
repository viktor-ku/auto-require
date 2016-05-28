fs = require 'fs'
path = require 'path'
reqr = require './reqr'

Array::drop = (element) ->
  if @indexOf(element) >= 0
    @splice @indexOf(element), 1
  return @

exports.modulesMap = (options) ->

  folders = []
  only = null
  without = null
  search = ['./node_modules/']

  if options

    if valid options.search
      {search} = options

    if valid options.only
      {only} = options

    else
      if valid options.without
        {without} = options

  for onePath in search

    try
      content = fs.readdirSync path.resolve onePath

    catch e
      if e.code is 'ENOENT'
        console.log """
          | WARN! No such file or directory.
          | #{e.path}
          | So this path will be empty."""
        content = []

    if only
      arr = []
      for one in content
        for onlyModule in only when one is onlyModule
          arr.push one
      folders.push arr
    else
      folders.push content

  for moduleGroups in folders

    if without

      for one in without
        moduleGroups.drop one

    for oneModule in moduleGroups
      if oneModule is '.bin' or oneModule is 'auto-require'
        moduleGroups.drop oneModule

  modulesMap = zipObject search, folders
  return modulesMap