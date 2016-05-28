exports.zipObject = (keys, values) ->

  object = {}
  
  for value, index in values

    if not keys[index]
      object.additional ?= []
      object.additional = object.additional.concat value
      continue

    object[keys[index]] = values[index]
  
  return object

exports.valid = (obj) ->
  if obj? and obj isnt '' and obj and obj.length > 0
    return yes