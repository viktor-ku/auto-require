const fs = require('fs')
const path = require('path')
const pkg = this.pkg || require('../package.json')
const contains = require('../utils/contains')
const drop = require('../utils/drop')
const zipObject = require('../utils/zipObject')

module.exports = function parseOptions (options) {
  options = options || {}
  const only = options.only
  const globaly = options.globaly || false
  let without = options.without
  const search = options.search || ['node_modules']

  let nm = search
    .filter(x => x.match('node_modules'))
    .map(x => [].concat(Object.keys(pkg.dependencies), Object.keys(pkg.devDependencies)))

  let custom = search
    .filter(x => !x.match('node_modules'))
    .map(x => fs.readdirSync(path.resolve(x)))

  let modules = [].concat(nm, custom)

  if (only && without) {
    without = undefined
  }

  if (only) {
    modules = modules.map(x => contains(x, only))
  }

  if (without) {
    modules = modules.map(x => drop(x, without))
  }

  return {
    schema: zipObject(search, modules),
    globaly: globaly
  }
}
