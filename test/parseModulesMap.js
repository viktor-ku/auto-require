const t = require('tap')
const parseModulesMap = require('../lib/parseModulesMap')

t.test('parseModulesMap', t => {
  const map = parseModulesMap({
    'node_modules/': [
      'gulp',
      'grunt'
    ],
    'custom-folder/': [
      'abba-new',
      'nano'
    ]
  })
  t.equal(map.packages.includes('gulp'), true)
  t.equal(map.packages.includes('grunt'), true)
  t.equal(map.packages.includes('abba-new'), true)
  t.equal(map.packages.includes('nano'), true)
  t.equal(map.fullPaths.includes('node_modules/gulp'), true)
  t.equal(map.fullPaths.includes('node_modules/grunt'), true)
  t.equal(map.fullPaths.includes('custom-folder/abba-new'), true)
  t.equal(map.fullPaths.includes('custom-folder/nano'), true)
  t.equal(map.fullPaths.includes('custom-folder/some-random-stuff'), false)
  t.equal(map.fullPaths.includes('node_modules/some-random-stuff-in-node'), false)
  t.end()
})
