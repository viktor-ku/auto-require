const t = require('tap')
const contains = require('../lib/contains')

t.test('contains', t => {
  t.deepEqual(contains([1, 2, 3], [2, 1]), [1, 2], 'contains 1, 2')
  t.deepEqual(contains(['one', 'two', 'three'], ['three']), ['three'], 'contains three')
  t.deepEqual(contains(['one', 'second', 'another'], ['sixth']), [], 'not contains')
  t.end()
})
