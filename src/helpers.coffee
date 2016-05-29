###*
 * zipObject
 *
 * Makes an object from first array as keys and second array
 * as values. In addition if values more than keys will store
 * the 'addition' key with those overhead values.
 *
 * @param {Array} keys First array
 * @param {Array} values Second array
 * @return {Object} Object as described above
###

exports.zipObject = (keys, values) ->

  o = {}

  values.forEach (value, index) ->

    if not keys[index]
      if not o.additional then o.additional = []
      o.additional.push value
      return

    o[keys[index]] = values[index]
      
  return o


###*
 * contains
 *
 * Check if the first array really contains things from second array
 *
 * @param {Array} a first array
 * @param {Array} b second array
 * @return {Array} New array based on what is first array actuall contains
###

exports.contains = (a, b) ->

  return a.filter (x) -> b.includes x


###*
 * drop
 *
 * Drop item from array
 *
 * @param {Array} array array from we dropping
 * @param {String / Number} item Item we want drop
 * @return {Array} New array that no longer contain the item
###

exports.drop = (array, item) ->

  return array.filter (x) -> x isnt item