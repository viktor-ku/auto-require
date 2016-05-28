gulp = require "gulp"
coffee = require "gulp-coffee"
prettify = require "gulp-jsbeautifier"
notify = require "gulp-notify"
plumber = require "gulp-plumber"

gulp.task "build", ->
  gulp.src "src/*.coffee"
    .pipe plumber errorHandler: notify.onError "Error: <%= error.message %>"
    .pipe coffee bare: on
    .pipe do prettify
    .pipe gulp.dest "dist/"

gulp.task "watch", ->
  gulp.watch "src/*.coffee", ["build"]

gulp.task "default", ["build", "watch"]