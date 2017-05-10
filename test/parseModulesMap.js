const t = require('tap')
const parseModulesMap = require('../lib/parseModulesMap')

t.test('parseModulesMap', t => {
  const input = {
    'node_modules/': [
      'gulp',
      'grunt'
    ],
    'custom-folder/': [
      'abba-new',
      'nano'
    ]
  }
  const map = parseModulesMap(input)
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
  
  const map2 = parseModulesMap(input, {grunt: 'GRNT'})
  t.equal(map2.packages.includes('gulp'), true)
  t.equal(map2.packages.includes('grunt'), false)
  t.equal(map2.packages.includes('GRNT'), true)
  t.equal(map2.packages.includes('abba-new'), true)
  t.equal(map2.packages.includes('nano'), true)
  t.equal(map2.fullPaths.includes('node_modules/gulp'), true)
  t.equal(map2.fullPaths.includes('node_modules/grunt'), true)
  t.equal(map2.fullPaths.includes('custom-folder/abba-new'), true)
  t.equal(map2.fullPaths.includes('custom-folder/nano'), true)
  t.equal(map2.fullPaths.includes('custom-folder/some-random-stuff'), false)
  t.equal(map2.fullPaths.includes('node_modules/some-random-stuff-in-node'), false)
  
  t.end()
})
