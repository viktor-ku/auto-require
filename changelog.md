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