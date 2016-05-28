###*
 * @reqr
 *
 * 
###

fs = require "fs"
path = require "path"
{ zipObject } = require "./helpers"

###*
 * init
 *
 * Initialization the auto-require process
 *
 * @param {Object} options Options to filter modules. Like only, search, etc.
 * @return {Object} Object with modules like that { gulp: [Function], express: [Function] }
###

exports.init = (options) -> reqr modulesMap options

exports.reqr = reqr = (entry) ->

  map = parseModulesMap entry
  packagesName = makePackagesName map.packages
  nodeModulesName = makeNodeModulesName map.fullPaths
  collection = zipObject packagesName, nodeModulesName

  return collection

exports.modulesMap = modulesMap = (options) ->

  folders = []
  only = null
  without = null
  search = ['./node_modules/']

  if options

    if options.search
      { search } = options

    if options.only
      { only } = options
    else
      if options.without
        { without } = options

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

exports.makePackagesName = makePackagesName = (packagesNames) ->

  packages = []

  for file in packagesNames

    part = file.split /[-.]/g

    if one part
      packages.push part

    else if exclusive part
      packages.push concatenation part[1...]

    else if not exclusive part
      packages.push concatenation part

  return packages

exports.parseModulesMap = parseModulesMap = (entry) ->

  packagesList = []
  fullPathsList = []

  for modulePath, modules of entry

    for one in modules

      packagesList.push one
      fullPathsList.push modulePath + one

  return {
    fullPaths: fullPathsList
    packages: packagesList
  }

exports.makeNodeModulesName = makeNodeModulesName = (packagesPaths) ->

  for file in packagesPaths
    require path.resolve file

exports.one = one = (arr) ->

  if arr.length is 1 then yes

exports.exclusive = exclusive = (arr) ->

  supportList = /(?:gulp|grunt|broccoli)/g

  if arr.join(" ").match(supportList)
    return on

exports.concat = concat = (part) ->

  part[0].toUpperCase() + part[1...]

exports.concatenation = concatenation = (arr) ->

  name = ""

  for el, i in arr
    if i is 0 then name += el
    else name += concat el

  return name