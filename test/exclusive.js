const t = require('tap')
const exclusive = require('../lib/exclusive')

t.test('exclusive', t => {
  t.equal(exclusive(['gulp', 'one', 'two']), true, 'gulp in array')
  t.equal(exclusive(['one', 'two']), false, 'gulp not in array')
  t.end()
})
