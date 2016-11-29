module.exports = function drop (a, b) {
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
