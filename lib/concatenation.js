module.exports = function concatenation (arr) {
  let name = ''

  arr.forEach((element, i) => {
    if (i === 0) {
      name += element
      return name
    } else {
      name += element[0].toUpperCase() + element.slice(1)
      return name
    }
  })

  return name
}
