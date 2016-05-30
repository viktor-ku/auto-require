module.exports = function(options) {
  if (options == null) {
    options = {};
  }
  return require("./reqr")
    .init(options);
};