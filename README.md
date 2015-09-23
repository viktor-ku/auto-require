# auto-require

**It's right way to automatically require your packages.**

Quick start
```javascript
npm install --save auto-require
```

Simple usage
```javascript
var $ = require('auto-require');

$.gulp.task('default', function() { 
	console.log('Do you see any gulp vars here?') 
});
```

It takes all modules in your `node_modules` folder and exports it as one module.

For example if we have `var $ = require('auto-require')` at the start we can access:
- Modules like `express`, `gulp` via `$.express` and `$.gulp`
- Modules like `gulp-jade` via `$.jade`
- Modules like `browser-sync`, `run-sequence` via `$.browserSync` and `$.runSequence`