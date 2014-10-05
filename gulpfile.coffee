gulp         = require 'gulp'
sass         = require 'gulp-sass'
autoprefixer = require 'gulp-autoprefixer'
minifyCss    = require 'gulp-minify-css'
rename       = require 'gulp-rename'
coffee       = require 'gulp-coffee'
jade         = require 'gulp-jade'
connect      = require 'gulp-connect'
react        = require 'gulp-react'
bowerFiles   = require 'main-bower-files'
uglify       = require 'gulp-uglify'
browserify   = require 'browserify'
source       = require 'vinyl-source-stream'

gulp.task 'css', ->
  gulp.src            './src/stylesheets/*.sass'
  .pipe sass sourceComments: 'normal'
  .pipe autoprefixer  'last 2 versions'
  .pipe minifyCss     keepSpecialComments: 0
  .pipe rename        extname: '.min.css'
  .pipe gulp.dest     './dest/stylesheets'
  .pipe connect.reload()

gulp.task 'lib-css', ->
  gulp.src            './lib/*.css'
  .pipe minifyCss     keepSpecialComments: 0
  .pipe rename        extname: '.min.css'
  .pipe gulp.dest     './dest/stylesheets'

gulp.task 'fonts', ->
  gulp.src ['./lib/*.eot', './lib/*.svg', './lib/*.tiff', './lib/*.woff']
  .pipe gulp.dest './dest/fonts'

gulp.task 'html', ->
  gulp.src            './src/html/*.jade'
  .pipe jade()
  .pipe gulp.dest     './dest/'
  .pipe connect.reload()

gulp.task 'js', ->
  browserify
    entries: ['./src/js/main.coffee']
    extensions: ['.coffee'] # CoffeeScriptも使えるように
  .bundle()
  .pipe source 'main.js' # 出力ファイル名を指定
  .pipe gulp.dest "./dest/js" # 出力ディレクトリを指定
  # .pipe uglify()
  # .pipe rename extname: '.min.js'
  # .pipe gulp.dest './dest/js/' # 2つ目のdest
  .pipe connect.reload()

gulp.task 'react', ->
  gulp.src './src/js/**/*.jsx'
  .pipe react()
  .pipe gulp.dest './dest/js'
  .pipe connect.reload()

gulp.task 'bower', ->
  gulp.src bowerFiles()
  .pipe gulp.dest './lib'
  gulp.start 'fonts', 'lib-css'
#
# gulp.task 'compress-libjs', ->
#   gulp.src "./lib/**/*.js"
#   .pipe uglify()
#   .pipe gulp.dest './dest/js'

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
    gulp.run 'react'


gulp.task 'default', ->
  gulp.run 'bower'
  gulp.run 'css'
  gulp.run 'html'
  gulp.run 'js'
  gulp.run 'react'
  gulp.run 'connect'
  gulp.run 'watch'
