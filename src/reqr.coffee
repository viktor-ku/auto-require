###*
 * @reqr
 *
 * 
###

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

  { only, global, without, search = ["node_modules/"] } = options

  nm = search
    .filter (x) ->
      x.match "node_modules"
    .map (x) ->
      JSON.parse(fs.readFileSync(path.resolve("package.json"), "utf-8"))
    .map (x) ->
      [].concat Object.keys(x.devDependencies), Object.keys(x.dependencies)

  custom = search
    .filter (x) ->
      not x.match "node_modules"
    .map (x) ->
      fs.readdirSync path.resolve x

  console.log "nm", nm
  console.log "custom", custom

  # if node_modules/
    # get packageDeps
    # return [array]

  # if custom search input
    # get all content

  # if only / without occurs, then exclude things from packageDeps

  console.log "search", search
  console.log "folders", folders

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