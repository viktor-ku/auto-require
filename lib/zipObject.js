module.exports = function zipObject (keys, values) {
  let o = {}

  values.forEach((value, index) => {
    if (!keys[index]) {
      if (!o.additional) {
        o.additional = []
      }
      o.additional.push(value)
    }

    o[keys[index]] = values[index]
  })

  return o
}
