fs = require "fs"
path = require "path"
{ zipObject, contains, drop } = require "./helpers"

###*
 * init
 *
 * Initialization the auto-require process
 *
 * @param {Object} options Options to filter modules. Like only, search, etc.
 * @return {Object} Object with modules like that { gulp: [Function], express: [Function] }
###

exports.init = (options) -> main modulesMap options


###*
 * main
 *
 * Require modules based on node modules folder map
 *
 * @param {Object} schema Schema by key "folder" => [packagesInFolder]
 * {"node_modules": [gulp, express]}
 * @return {Object} Object that contains all modules by "name" => [Function]
###

main = ({ schema, globaly }) ->

  map = parseModulesMap schema
  packagesName = makePackagesName map.packages
  nodeModulesName = makeNodeModulesName map.fullPaths
  collection = zipObject packagesName, nodeModulesName
  if globaly then global[k] = v for k, v of collection
  return collection


###*
 * modulesMap
 *
 * Generate schema for main.
 * The schema means "folderName": [folderContent]
 *
 * @param {Object} options Options like only, without, etc
 * @return {Object} Object as described above
###

exports.modulesMap = modulesMap = (options = {}) ->

  { only, globaly = no, without, search = ["node_modules/"] } = options

  nm = search
    .filter (x) ->
      x.match "node_modules"
    .map (x) ->
      JSON.parse(fs.readFileSync(path.resolve("package.json"), "utf-8"))
    .map (x) ->
      [].concat Object.keys(x.dependencies), Object.keys(x.devDependencies)

  custom = search
    .filter (x) ->
      not x.match "node_modules"
    .map (x) ->
      fs.readdirSync path.resolve x

  modules = [].concat nm, custom

  if only and without then without = undefined

  if only
    modules = modules.map (x) -> contains x, only

  if without
    modules = modules.map (x) -> drop x, without

  schema = zipObject search, modules
  return { schema, globaly }


###*
 * makePackagesName
 *
 * Makes names for incoming packages, e.g. "gulp-plumber" => "gulpPlumber"
 * 
 * @param {Array} packagesNames Names for those packages
 * @return {Array} New array with names (for packages)
###

exports.makePackagesName = makePackagesName = (packagesNames) ->

  return packagesNames.map (file, i, arr) ->

    part = file.split /[-.]/g

    if one part
      return part[0]

    else if exclusive part
      return concatenation part[1...]

    else if not exclusive part
      return concatenation part


###*
 * parseModulesMap
 *
 * Generate advanced packages map, so we can include packages directly
 * to the output object
 *
 * @param {Object} schema Schema object that contains folder name and
 * it's content (folder names)
 * @return {Object} fullpaths: [packagesPaths], packages: [packagesName]
###

exports.parseModulesMap = parseModulesMap = (schema) ->

  packages = []
  fullPaths = []

  for key, modules of schema

    modules.forEach (module) ->

      packages.push module
      fullPaths.push key + module

  result = { fullPaths, packages }

  return result


###*
 * makeNodeModulesName
 *
 * Function that requires the modules by the packages paths given above
 * 
 * @param {Array} packagesPaths Full paths for the packages
 * @return {Array} Modules
###

exports.makeNodeModulesName = makeNodeModulesName = (packagesPaths) ->

  return packagesPaths.map (file) ->
    require path.resolve file


###*
 * one
 *
 * Check if given array has one item only
 *
 * @param {Array} arr Array to check
 * @return {Boolean} One item or not
###

exports.one = one = (arr) ->

  if arr.length is 1
    return on


###*
 * exclusive
 *
 * Check if given array has exclusive item like
 * gulp, grunt, etc
 *
 * @param {Array} arr Array to check
 * @return {Boolean} Item is exclusive or not
###

exports.exclusive = exclusive = (arr) ->

  supportList = /(?:gulp|grunt|broccoli)/g

  if arr.join(" ").match(supportList)
    return on


###*
 * concatenation
 *
 * Function that transforms array into string that contains
 * completed name for the packages that will be used
 *
 * @param {Array} arr Array to transform
 * @return {String} Completed string
###

exports.concatenation = concatenation = (arr) ->

  name = ""

  arr.forEach (element, i) ->

    if i is 0
      return name += element
    else
      return name += element[0].toUpperCase() + element[1...]

  return name