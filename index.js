const parseOptions = require('./lib/parseOptions')
const parseModulesMap = require('./lib/parseModulesMap')
const makePackageNames = require('./lib/makePackageNames')
const requireModules = require('./lib/requireModules')
const zipObject = require('./lib/zipObject')

module.exports = function autoRequire (options) {
  options = parseOptions(options)
  const schema = options.schema
  const globaly = options.globaly
  const map = parseModulesMap(schema)
  const packageNames = makePackageNames(map.packages)
  const modules = requireModules(map.fullPaths)
  const collection = zipObject(packageNames, modules)
  if (globaly) {
    for (const k in collection) {
      global[k] = collection[k]
    }
  }
  return collection
}
