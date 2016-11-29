module.exports = function parseModulesMap (schema) {
  const packages = []
  const fullPaths = []

  Object.keys(schema).forEach(key => {
    schema[key].forEach(module => {
      packages.push(module)
      fullPaths.push(key + module)
    })
  })

  return {
    fullPaths: fullPaths,
    packages: packages
  }
}
