const t = require('tap')
const drop = require('../lib/drop')

t.test('drop', t => {
  t.deepEqual(drop([1, 2, 3], [2]), [1, 3])
  t.deepEqual(drop(['one', 'two', 'three'], ['three', 'four']), ['one', 'two'])
  t.end()
})
