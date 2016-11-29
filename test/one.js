const t = require('tap')
const one = require('../lib/one')

t.test('one', t => {
  t.equal(one(['first element']), true, 'one is true when array length is 1')
  t.equal(one(['first element', 'second element']), false, 'one is false when array length is not 1')
  t.end()
})
