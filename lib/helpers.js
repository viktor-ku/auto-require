exports.zipObject = function zipObject (keys, values) {
  let o = {}

  values.forEach((value, index) => {
    if (!keys[index]) {
      if (!o.additional) { o.additional = [] }
      o.additional.push(value)
      return
    }

    o[keys[index]] = values[index]
  })

  return o
}

exports.contains = function contains (a, b) {
  return a.filter(x => b.includes(x))
}

exports.drop = function drop (a, b) {
  a.forEach(x =>
    b.forEach(y => {
      if (x === y) {
        a[a.indexOf(x)] = null
      }
    })
  )

  return a.filter(x => {
    if (x === 0) {
      return true
    } else {
      return x
    }
  })
}
