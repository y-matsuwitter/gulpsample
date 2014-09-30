gulp         = require 'gulp'
sass         = require 'gulp-sass'
autoprefixer = require 'gulp-autoprefixer'
minifyCss    = require 'gulp-minify-css'
rename       = require 'gulp-rename'

gulp.task 'css', ->
  gulp.src            './src/stylesheets/*.sass'
  .pipe sass sourceComments: 'normal'
  .pipe autoprefixer  'last 2 versions'
  .pipe minifyCss     keepSpecialComments: 0
  .pipe rename        extname: '.min.css'
  .pipe gulp.dest     './dest/stylesheets'

gulp.task 'default', ->
  gulp.run 'css'
