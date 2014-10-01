gulp         = require 'gulp'
sass         = require 'gulp-sass'
autoprefixer = require 'gulp-autoprefixer'
minifyCss    = require 'gulp-minify-css'
rename       = require 'gulp-rename'
coffee       = require 'gulp-coffee'
jade         = require 'gulp-jade'
connect      = require 'gulp-connect'

gulp.task 'css', ->
  gulp.src            './src/stylesheets/*.sass'
  .pipe sass sourceComments: 'normal'
  .pipe autoprefixer  'last 2 versions'
  .pipe minifyCss     keepSpecialComments: 0
  .pipe rename        extname: '.min.css'
  .pipe gulp.dest     './dest/stylesheets'
  .pipe connect.reload()

gulp.task 'html', ->
  gulp.src            './src/html/*.jade'
  .pipe jade()
  .pipe gulp.dest     './dest/'
  .pipe connect.reload()

gulp.task 'js', ->
  gulp.src './src/js/*.coffee'
  .pipe coffee bare: true
  .pipe gulp.dest './dest/js'
  .pipe connect.reload()

gulp.task 'connect', ->
  connect.server
    root: 'dest',
    port: 8088,
    livereload: true

gulp.task 'watch', ->
  gulp.watch "./src/stylesheets/**"
  .on 'change', ->
    gulp.run 'css'
  gulp.watch "./src/html/**"
  .on 'change', ->
    gulp.run 'html'
  gulp.watch "./src/js/**"
  .on 'change', ->
    gulp.run 'js'


gulp.task 'default', ->
  gulp.run 'css'
  gulp.run 'html'
  gulp.run 'js'
  gulp.run 'connect'
  gulp.run 'watch'
