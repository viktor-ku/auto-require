const exclusive = require('./exclusive')
const camelCase = require('lodash.camelcase')

module.exports = function makePackageNames (packagesNames) {
  return packagesNames.map((file, i, arr) => {
    const part = file.split(/[-.]/g)

    if (part.length === 1) {
      return part[0]
    } else if (exclusive(part)) {
      return camelCase(part.slice(1))
    } else if (!exclusive(part)) {
      return camelCase(part)
    }
  })
}
