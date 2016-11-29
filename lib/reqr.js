const fs = require('fs')
const pkg = require('../package.json')
const path = require('path')
const { zipObject, contains, drop } = require('./helpers')

function init (options) {
  return main(modulesMap(options))
}

function main ({ schema, globaly }) {
  let map = parseModulesMap(schema)
  let packagesName = makePackagesName(map.packages)
  let nodeModulesName = makeNodeModulesName(map.fullPaths)
  let collection = zipObject(packagesName, nodeModulesName)
  if (globaly) {
    for (let k in collection) {
      global[k] = collection[k]
    }
  }
  return collection
}

function modulesMap (options) {
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

  let schema = zipObject(search, modules)
  return { schema, globaly }
}

function makePackagesName (packagesNames) {
  packagesNames.map((file, i, arr) => {
    let part = file.split(/[-.]/g)

    if (one(part)) {
      return part[0]
    } else if (exclusive(part)) {
      return concatenation(part.slice(1))
    } else if (!exclusive(part)) {
      return concatenation(part)
    }
  })
}

function parseModulesMap (schema) {
  let packages = []
  let fullPaths = []

  for (let key in schema) {
    let modules = schema[key]
    modules.forEach(module => {
      packages.push(module)
      return fullPaths.push(key + module)
    })
  }

  let result = { fullPaths, packages }

  return result
}

function makeNodeModulesName (packagesPaths) {
  packagesPaths.map(file => require(path.resolve(file)))
}

function one (arr) {
  if (arr.length === 1) {
    return true
  }
}

function exclusive (arr) {
  let supportList = /(?:gulp|grunt|broccoli)/g

  if (arr.join(' ').match(supportList)) {
    return true
  }
}

function concatenation (arr) {
  let name = ''

  arr.forEach((element, i) => {
    if (i === 0) {
      name += element
      return name
    } else {
      name += element[0].toUpperCase() + element.slice(1)
      return name
    }
  })

  return name
}

module.exports = {
  init: init
}
