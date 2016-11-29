const t = require('tap')
const requireModules = require('../lib/requireModules')

t.test('requireModules', t => {
  const packages = requireModules(['node_modules/eslint'])
  t.equal(Array.isArray(packages), true, 'packages is array')
  t.end()
})
