const one = require('./one')
const exclusive = require('./exclusive')
const concatenation = require('./concatenation')

module.exports = function makePackageNames (packagesNames) {
  return packagesNames.map((file, i, arr) => {
    const part = file.split(/[-.]/g)

    if (one(part)) {
      return part[0]
    } else if (exclusive(part)) {
      return concatenation(part.slice(1))
    } else if (!exclusive(part)) {
      return concatenation(part)
    }
  })
}
