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
 * @param {Array} a Array from we dropping
 * @param {Array} b Array with values we drop
 * @return {Array} New array that no longer contain the second array values
###

exports.drop = (a, b) ->

  a.forEach (x) ->
    b.forEach (y) ->
      if x is y then a[a.indexOf(x)] = null
  
  return a.filter (x) -> if x is 0 then on else x