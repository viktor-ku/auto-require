const path = require('path')

module.exports = function requireModules (packagesPaths) {
  return packagesPaths.map(file => require(path.resolve(file)))
}
