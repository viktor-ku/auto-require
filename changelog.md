# 2.0.0

##### API changes

Now you must specify all options straight into object.

```js
options = {}

var $ = require('auto-require')(options)
```

##### Add without and search options

Each options must have an array as a value.

```js
options = {
	search: ['./node_modules/', './my-modules/', './my-another-modules/']
	without: ['snapsvg', 'jquery']
}

var $ = require('auto-require')(options)
```

**NB** When you specify `only` option - `without` option will be  
ignored.

# 1.5

##### Now you need to call the function to get all modules

```js
var $ = require('auto-require')();
```

##### Removed `only()` function

Now you need to pass an array as a parameter into callback

```js
var $ = require('auto-require')(['gulp', 'gulp-stylus', 'browser-sync']);
```

##### Replace some validation with RegExp