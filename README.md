# auto-require

**It's right way to automatically require your packages.**

Install
```
npm install --save auto-require
```

Quick start with gulp `gulpfile.js`
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

**It takes all modules in your `node_modules` folder and exports it as one module**  
For example we can access:
- `express` via `$.express`
- `browser-sync` via `$.browserSync`
- `andyet-express-auth` via `$.andyetExpressAuth`
- `gulp` via `$.gulp`
- `gulp-plumber` via `$.plumber` 
- `gulp-inline-css` via `$.inlineCss`
- `grunt` via `$.grunt`
- `grunt-shell` via `$.shell`
- `grunt-conventional-changelog` via `$.conventionalChangelog`