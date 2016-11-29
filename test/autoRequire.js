const t = require('tap')
const autoRequire = require('../index')

t.test('autoRequire', t => {
  const collection = autoRequire()
  t.ok(collection)
  t.ok(Object.keys(collection).length)
  t.end()
})
