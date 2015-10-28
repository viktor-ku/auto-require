# auto-require
![tests passed](https://img.shields.io/badge/tests-19%2F19-brightgreen.svg?style=flat-square "tests passed")
![build success](https://img.shields.io/badge/build-success-brightgreen.svg?style=flat-square "build success")

## It's the best way to automatically require your packages

Checkout [changelog](changelog.md) also

### install

```
npm install --save auto-require
```

### get into with gulp
```js
var $ = require('auto-require')();

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
Actually it's pretty straightforward - via `$.jade`.  
As you can see the first part of the `gulp-jade` has been cut.  

This tool works fine with *gulp*, *grunt*, *broccoli* and *jquery*.

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

```js
// specify only packages you need
var need = ['gulp', 'gulp-stylus', 'gulp-plumber'];
var $ = require('auto-require')(need);

$.gulp.task('stylus', function() {
	$.gulp.src('styl/app.styl')
		.pipe($.plumber())
		.pipe($.stylus())
		.pipe($.gulp.dest('dest/'));
});
```