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

  a.filter (x) -> b.includes x


###*
 * drop
 *
 * Drop item from array
 *
 * @param {Array} array array from we dropping
 * @param {String / Number} item Item we drop
 * @return {Array} New array that no longer contain the item
###

exports.drop = (array, item) ->

  array.filter (x) -> x isnt item