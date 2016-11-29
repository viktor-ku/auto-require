const t = require('tap')
const parseOptions = require('../lib/parseOptions')

t.test('parseOptions', t => {
  const options = parseOptions({
    without: ['eslint-config-standard', 'eslint-plugin-promise', 'eslint-plugin-standard']
  })
  t.equal(options.globaly, false, 'globaly should be set to false by default')
  t.ok(options.schema)
  t.ok(options.schema['node_modules/'])
  t.equal(Array.isArray(options.schema['node_modules/']), true)
  t.equal(options.schema['node_modules/'].includes('eslint'), true)
  t.equal(options.schema['node_modules/'].includes('tap'), true)
  t.equal(options.schema['node_modules/'].includes('lodash.camelcase'), true)
  t.equal(options.schema['node_modules/'].includes('lodash.zipobject'), true)
  t.equal(options.schema['node_modules/'].includes('eslint-config-standard'), false)
  t.equal(options.schema['node_modules/'].includes('eslint-plugin-promise'), false)
  t.equal(options.schema['node_modules/'].includes('eslint-plugin-standard'), false)
  t.end()
})
