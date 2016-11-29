module.exports = function contains (a, b) {
  return a.filter(x => b.includes(x))
}
