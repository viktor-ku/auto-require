module.exports = function parseModulesMap (schema, as) {
  const packages = []
  const fullPaths = []
  as = as || {}

  Object.keys(schema).forEach(key => {
    schema[key].forEach(module => {
      packages.push(as[module] ? as[module] : module)
      fullPaths.push(key + module)
    })
  })

  return {
    fullPaths: fullPaths,
    packages: packages
  }
}
