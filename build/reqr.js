var concatenation, contains, drop, exclusive, fs, main, makeNodeModulesName, makePackagesName, modulesMap, one, parseModulesMap, path, ref, zipObject;

fs = require("fs");

path = require("path");

ref = require("./helpers"), zipObject = ref.zipObject, contains = ref.contains, drop = ref.drop;


/**
 * init
 *
 * Initialization the auto-require process
 *
 * @param {Object} options Options to filter modules. Like only, search, etc.
 * @return {Object} Object with modules like that { gulp: [Function], express: [Function] }
 */

exports.init = function(options) {
  return main(modulesMap(options));
};


/**
 * main
 *
 * Require modules based on node modules folder map
 *
 * @param {Object} schema Schema by key "folder" => [packagesInFolder]
 * {"node_modules": [gulp, express]}
 * @return {Object} Object that contains all modules by "name" => [Function]
 */

main = function(arg) {
  var collection, globaly, k, map, nodeModulesName, packagesName, schema, v;
  schema = arg.schema, globaly = arg.globaly;
  map = parseModulesMap(schema);
  packagesName = makePackagesName(map.packages);
  nodeModulesName = makeNodeModulesName(map.fullPaths);
  collection = zipObject(packagesName, nodeModulesName);
  if (globaly) {
    for (k in collection) {
      v = collection[k];
      global[k] = v;
    }
  }
  return collection;
};


/**
 * modulesMap
 *
 * Generate schema for main.
 * The schema means "folderName": [folderContent]
 *
 * @param {Object} options Options like only, without, etc
 * @return {Object} Object as described above
 */

exports.modulesMap = modulesMap = function(options) {
  var custom, globaly, modules, nm, only, ref1, ref2, schema, search, without;
  if (options == null) {
    options = {};
  }
  only = options.only, globaly = (ref1 = options.globaly) != null ? ref1 : false, without = options.without, search = (ref2 = options.search) != null ? ref2 : ["node_modules/"];
  nm = search.filter(function(x) {
      return x.match("node_modules");
    })
    .map(function(x) {
      return JSON.parse(fs.readFileSync(path.resolve("package.json"), "utf-8"));
    })
    .map(function(x) {
      return [].concat(Object.keys(x.dependencies), Object.keys(x.devDependencies));
    });
  custom = search.filter(function(x) {
      return !x.match("node_modules");
    })
    .map(function(x) {
      return fs.readdirSync(path.resolve(x));
    });
  modules = [].concat(nm, custom);
  if (only && without) {
    without = void 0;
  }
  if (only) {
    modules = modules.map(function(x) {
      return contains(x, only);
    });
  }
  if (without) {
    modules = modules.map(function(x) {
      return drop(x, without);
    });
  }
  schema = zipObject(search, modules);
  return {
    schema: schema,
    globaly: globaly
  };
};


/**
 * makePackagesName
 *
 * Makes names for incoming packages, e.g. "gulp-plumber" => "gulpPlumber"
 * 
 * @param {Array} packagesNames Names for those packages
 * @return {Array} New names for packages
 */

exports.makePackagesName = makePackagesName = function(packagesNames) {
  var file, j, len, packages, part;
  packages = [];
  for (j = 0, len = packagesNames.length; j < len; j++) {
    file = packagesNames[j];
    part = file.split(/[-.]/g);
    if (one(part)) {
      packages.push(part);
    } else if (exclusive(part)) {
      packages.push(concatenation(part.slice(1)));
    } else if (!exclusive(part)) {
      packages.push(concatenation(part));
    }
  }
  return packages;
};


/**
 * parseModulesMap
 *
 * Generate advanced packages map, so we can include packages directly
 * to the output object
 *
 * @param {Object} schema Schema object that contains folder name and
 * it's content (folder names)
 * @return {Object} fullpaths: [packagesPaths], packages: [packagesName]
 */

exports.parseModulesMap = parseModulesMap = function(schema) {
  var fullPaths, key, modules, packages, result;
  packages = [];
  fullPaths = [];
  for (key in schema) {
    modules = schema[key];
    modules.forEach(function(module) {
      packages.push(module);
      return fullPaths.push(key + module);
    });
  }
  result = {
    fullPaths: fullPaths,
    packages: packages
  };
  return result;
};


/**
 * makeNodeModulesName
 *
 * Function that requires the modules by the packages paths given above
 * 
 * @param {Array} packagesPaths Full paths for the packages
 * @return {Array} Modules
 */

exports.makeNodeModulesName = makeNodeModulesName = function(packagesPaths) {
  return packagesPaths.map(function(file) {
    return require(path.resolve(file));
  });
};


/**
 * one
 *
 * Check if given array has one item only
 *
 * @param {Array} arr Array to check
 * @return {Boolean} One item or not
 */

exports.one = one = function(arr) {
  if (arr.length === 1) {
    return true;
  }
};


/**
 * exclusive
 *
 * Check if given array has exclusive item like
 * gulp, grunt, etc
 *
 * @param {Array} arr Array to check
 * @return {Boolean} Item is exclusive or not
 */

exports.exclusive = exclusive = function(arr) {
  var supportList;
  supportList = /(?:gulp|grunt|broccoli)/g;
  if (arr.join(" ")
    .match(supportList)) {
    return true;
  }
};


/**
 * concatenation
 *
 * Function that transforms array into string that contains
 * completed name for the packages that will be used
 *
 * @param {Array} arr Array to transform
 * @return {String} Completed string
 */

exports.concatenation = concatenation = function(arr) {
  var name;
  name = "";
  arr.forEach(function(element, i) {
    if (i === 0) {
      return name += element;
    } else {
      return name += element[0].toUpperCase() + element.slice(1);
    }
  });
  return name;
};