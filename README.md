# auto-require
![dependencies](https://img.shields.io/badge/dependencies-up--to--date-green.svg "dependencies")
![tests passed](https://img.shields.io/badge/tests-17%2F17-green.svg "tests passed")

**It's the best way to automatically require your packages**

### Install

```
npm install --save auto-require
```

### Quick start with gulp
```javascript
var $ = require('auto-require');

$.gulp.task('default', function() { 
	$.gulp.src('src/*.jade')
		.pipe($.plumber())
		.pipe($.jade())
		.pipe($.util.log('Do you see any gulp, plumber, jade, util var definitions here?'))
		.pipe($.gulp.dest('dest/'));
});
```

### What it does?

It takes all modules in your `node_modules` folder and exports it as one module,  
so you can access them all.  

Quick example
- `express` via `$.express`
- `browser-sync` via `$.browserSync`
- `gulp` via `$.gulp`
- `gulp-inline-css` via `$.inlineCss`

### What about jQuery or build tools?

No, you'll not need to write full module name.
The first part of the module name will be cut in this case.    
For example we have `gulp-jade` module. How we can access it?  
Answer is as simple as it even can be - via `$.jade`.  
As you can see the first part of the `gulp-jade` has been cut.  

This tool supports *gulp*, *grunt*, *broccoli* and *jquery*.

### Other access examples

- `gulp` via `$.gulp`
- `gulp-plumber` via `$.plumber` 
- `gulp-inline-css` via `$.inlineCss`
- `grunt` via `$.grunt`
- `grunt-shell` via `$.shell`
- `grunt-conventional-changelog` via `$.conventionalChangelog`
- `broccoli-file-contents-to-json` via `$.fileContentsToJson`
- `express` via `$.express`
- `browser-sync` via `$.browserSync`
- `andyet-express-auth` via `$.andyetExpressAuth`

### Limited access

```javascript
// specify only packages you need
var need = ['gulp', 'gulp-stylus', 'gulp-plumber'];
// use only() function to access only them
var $ = require('auto-require').only(need);

// use as you need
$.gulp.task('stylus', function() {
	$.gulp.src('styl/app.styl')
		.pipe($.plumber())
		.pipe($.stylus())
		.pipe($.gulp.dest('dest/'));
});
```