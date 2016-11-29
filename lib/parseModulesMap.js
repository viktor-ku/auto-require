module.exports = function parseModulesMap (schema) {
  const packages = []
  const fullPaths = []

  for (const key in schema) {
    const modules = schema[key]
    modules.forEach(module => {
      packages.push(module)
      return fullPaths.push(key + module)
    })
  }

  return {
    fullPaths: fullPaths,
    packages: packages
  }
}
