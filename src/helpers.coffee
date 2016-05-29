exports.zipObject = (keys, values) ->

  object = {}
  
  for value, index in values

    if not keys[index]
      object.additional ?= []
      object.additional = object.additional.concat value
      continue

    object[keys[index]] = values[index]
  
  return object


exports.contains = (a, b) ->

  a.filter (x) -> b.includes x


exports.drop = (array, item) ->

  if not array.includes item then return array

  array.filter (x) -> x isnt item