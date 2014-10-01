gulp         = require 'gulp'
sass         = require 'gulp-sass'
autoprefixer = require 'gulp-autoprefixer'
minifyCss    = require 'gulp-minify-css'
rename       = require 'gulp-rename'
livereload   = require 'gulp-livereload'
coffee       = require 'gulp-coffee'
jade         = require 'gulp-jade'

gulp.task 'css', ->
  gulp.src            './src/stylesheets/*.sass'
  .pipe sass sourceComments: 'normal'
  .pipe autoprefixer  'last 2 versions'
  .pipe minifyCss     keepSpecialComments: 0
  .pipe rename        extname: '.min.css'
  .pipe gulp.dest     './dest/stylesheets'
  .pipe livereload()

gulp.task 'html', ->
  gulp.src            './src/html/*.jade'
  .pipe jade()
  .pipe gulp.dest     './dest/html'
  .pipe livereload()

gulp.task 'js', ->
  gulp.src './src/js/*.coffee'
  .pipe coffee bare: true
  .pipe gulp.dest './dest/js'
  .pipe livereload()

gulp.task 'default', ->
  livereload.listen()
  gulp.run 'css'
  gulp.run 'html'
  gulp.run 'js'
  gulp.watch "./src/stylesheets/**"
  .on 'change', ->
    gulp.run 'css'
  gulp.watch "./src/html/**"
  .on 'change', ->
    gulp.run 'html'
  gulp.watch "./src/js/**"
  .on 'change', ->
    gulp.run 'js'
