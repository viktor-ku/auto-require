# auto-require
![tests passed](https://camo.githubusercontent.com/7d0c5b8519d233167e941de8f3f964fda2a93fe5/687474703a2f2f662e636c2e6c792f6974656d732f32483233334d30493054343333313363336830432f53637265656e25323053686f74253230323031332d30312d33302532306174253230322e34352e3330253230414d2e706e67 "tests passed")

## It's the best way to automatically require your packages

Checkout [changelog](changelog.md) also

### install

```
npm install --save auto-require
```

### get into with gulp
```js
// get all modules from 'node_modules/' only
var $ = require('auto-require')();

$.gulp.task('default', function() { 
	$.gulp.src('src/*.jade')
		.pipe($.plumber())
		.pipe($.jade())
		.pipe($.util.log('Do you see any gulp, plumber, jade, util var definitions here?'))
		.pipe($.gulp.dest('dest/'));
});
```

### Options

**1. Get modules you only need**

```js
var options = {
	only: ['gulp', 'gulp-stylus', 'gulp-plumber']
};
var $ = require('auto-require')(options);

$.gulp.task('stylus', function() {
	$.gulp.src('styl/app.styl')
		.pipe($.plumber())
		.pipe($.stylus())
		.pipe($.gulp.dest('dest/'));
});
```

**2. Get modules you only need from different places**

```js
var options = {
	search: ['./node_modules/', './my-custom-folder/'],
	only: ['gulp', 'gulp-stylus', 'gulp-plumber']
};
var $ = require('auto-require')(options);

$.gulp.task('stylus', function() {
	$.gulp.src('styl/app.styl')
		.pipe($.plumber())
		.pipe($.stylus())
		.pipe($.gulp.dest('dest/'));
});
```

**2. Get all modules without some. From different places in this case.**

```js
var options = {
	search: ['./node_modules/', './my-custom-folder/'],
	without: ['blazer', 'jquery']
};
var $ = require('auto-require')(options);

$.gulp.task('stylus', function() {
	$.gulp.src('styl/app.styl')
		.pipe($.plumber())
		.pipe($.stylus())
		.pipe($.gulp.dest('dest/'));
});
```

**NB! if you using `only` option - `without` opton will be ignored**

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