/**
 * zipObject
 *
 * Makes an object from first array as keys and second array
 * as values. In addition if values more than keys will store
 * the 'addition' key with those overhead values.
 *
 * @param {Array} keys First array
 * @param {Array} values Second array
 * @return {Object} Object as described above
 */
exports.zipObject = function(keys, values) {
  var o;
  o = {};
  values.forEach(function(value, index) {
    if (!keys[index]) {
      if (!o.additional) {
        o.additional = [];
      }
      o.additional.push(value);
      return;
    }
    return o[keys[index]] = values[index];
  });
  return o;
};


/**
 * contains
 *
 * Check if the first array really contains things from second array
 *
 * @param {Array} a first array
 * @param {Array} b second array
 * @return {Array} New array based on what is first array actuall contains
 */

exports.contains = function(a, b) {
  return a.filter(function(x) {
    return b.includes(x);
  });
};


/**
 * drop
 *
 * Drop item from array
 *
 * @param {Array} a Array from we dropping
 * @param {Array} b Array with values we drop
 * @return {Array} New array that no longer contain the second array values
 */

exports.drop = function(a, b) {
  a.forEach(function(x) {
    return b.forEach(function(y) {
      if (x === y) {
        return a[a.indexOf(x)] = null;
      }
    });
  });
  return a.filter(function(x) {
    if (x === 0) {
      return true;
    } else {
      return x;
    }
  });
};