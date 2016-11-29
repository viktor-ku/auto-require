const t = require('tap')
const makePackageNames = require('../lib/makePackageNames')

t.test('makePackageNames', t => {
  t.deepEqual(makePackageNames(['abba-name', 'anna']), ['abbaName', 'anna'])
  t.deepEqual(makePackageNames(['lodash.zipobject']), ['lodashZipobject'])
  t.deepEqual(makePackageNames(['gulp-plumber', 'gulp']), ['plumber', 'gulp'])
  t.deepEqual(makePackageNames(['broccoli-sass', 'grunt-as-lodash']), ['sass', 'asLodash'])
  t.end()
})
