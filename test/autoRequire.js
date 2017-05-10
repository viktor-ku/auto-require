const t = require('tap')
const autoRequire = require('../index')

t.test('autoRequire', t => {
  const collection = autoRequire({
    globaly: true
  })
  t.ok(collection)
  t.ok(collection.lodashCamelcase)
  t.ok(collection.lodashZipobject)
  t.ok(collection.eslint)
  t.deepEqual(collection.eslint, global.eslint)
  t.ok(Object.keys(collection).length)
  t.throws(() => eslint = {})
  t.end()
})
