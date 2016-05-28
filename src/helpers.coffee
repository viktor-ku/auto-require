exports.zipObject = (keys, values) ->

  object = {}
  
  for value, index in values

    if not keys[index]
      object.additional ?= []
      object.additional = object.additional.concat value
      continue

    object[keys[index]] = values[index]
  
  return object

Array::drop = (element) ->
  if @indexOf(element) >= 0
    @splice @indexOf(element), 1
  return @