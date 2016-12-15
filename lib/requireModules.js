const path = require('path')

module.exports = function requireModules (packagesPaths) {
  return packagesPaths.map(file => {
    const pathFile = path.resolve(process.cwd(), file)
    return require(pathFile)
  })
}
