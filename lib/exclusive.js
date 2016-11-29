module.exports = function exclusive (arr) {
  let supportList = /(?:gulp|grunt|broccoli)/g

  if (arr.join(' ').match(supportList)) {
    return true
  }
}
