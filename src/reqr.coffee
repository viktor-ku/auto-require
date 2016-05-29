###*
 * @reqr
 *
 * 
###

fs = require "fs"
path = require "path"
{ zipObject, contains } = require "./helpers"

###*
 * init
 *
 * Initialization the auto-require process
 *
 * @param {Object} options Options to filter modules. Like only, search, etc.
 * @return {Object} Object with modules like that { gulp: [Function], express: [Function] }
###

exports.init = (options) -> reqr modulesMap options


###*
 * reqr
 *
 * Require modules based on node modules folder map
 *
 * @param {Object} modulesSchema Schema by key "folder" => [packagesInFolder]
 * {"node_modules": [gulp, express]}
 * @return {Object} Object that contains all modules by "name" => [Function]
###

exports.reqr = reqr = (modulesSchema) ->

  map = parseModulesMap modulesSchema
  packagesName = makePackagesName map.packages
  nodeModulesName = makeNodeModulesName map.fullPaths
  collection = zipObject packagesName, nodeModulesName

  return collection


###*
 * modulesMap
 *
 * Generate schema for reqr.
 * The schema means "folderName": [module as folderContent]
 *
 * @param {Object} options Options like only, without, etc...
 * @return {Object} Object as mension above.
###

exports.modulesMap = modulesMap = (options) ->

  # define
  folders = []
  only = null
  without = null
  search = ['./node_modules/']

  # if there any options?
  #   - get values from there and set those to the defined vars earlier
  if options

    if options.search
      { search } = options

    if options.only
      { only } = options
    else
      if options.without
        { without } = options

  # get content from each search paths
  # push it into folders array
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
      folders.push contains content, only
      # arr = []
      # for one in content
      #   for onlyModule in only
      #     if one is onlyModule then arr.push one
      # folders.push arr
    else
      folders.push content

  for moduleGroups in folders

    if without

      for one in without
        moduleGroups.drop one

    for oneModule in moduleGroups
      if oneModule is '.bin' or oneModule is 'auto-require'
        moduleGroups.drop oneModule

  return zipObject search, folders


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