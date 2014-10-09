gulp        = require 'gulp'
stylus      = require 'gulp-stylus'
minifyCSS   = require 'gulp-minify-css'
jade        = require 'gulp-jade'
htmlmin     = require 'gulp-htmlmin'
prefix      = require 'gulp-autoprefixer'
coffee      = require 'gulp-coffee'
uglify      = require 'gulp-uglify'
sourcemaps  = require 'gulp-sourcemaps'
concat      = require 'gulp-concat'
svgmin      = require 'gulp-svgmin'
svg2png     = require 'gulp-svg2png'
prettify    = require 'gulp-html-prettify'
cssbeautify = require 'gulp-cssbeautify'
ghpages     = require 'gh-pages'
path        = require 'path'
w3cjs       = require 'gulp-w3cjs'
esformatter = require 'gulp-esformatter'
coffeelint  = require 'gulp-coffeelint'

imagemin    = require 'gulp-imagemin'
pngcrush    = require 'imagemin-pngcrush'

dev_path =
  jade:       'developer/jade/**.jade'
  css:        'developer/css/**.css'
  css_tmp:    'developer/css/'
  images:     'developer/images/**'
  js:         'developer/js/**.js'
  coffee:     'developer/coffee/**.coffee'
  stylus:     'developer/stylus/**.styl'
  fonts:      'developer/fonts/**'
  svg:        'developer/svg/**/*.svg'

prod_path =
  html:       'production/'
  js:         'production/js/'
  css:        'production/css/'
  fonts:      'production/fonts/'
  svg:        'production/svg/'
  images:     'production/images/'
  images2x:   'production/images2x/'


gulp.task('fonts', ()->
  return gulp.src(dev_path.fonts)
    .pipe(gulp.dest(prod_path.fonts))
)

gulp.task('svg', ()->
  return gulp.src(dev_path.svg)
    .pipe(svgmin())
    .pipe(gulp.dest(prod_path.svg))
)

gulp.task('images', ()->
  return gulp.src(dev_path.images)
    .pipe(imagemin({
        progressive: true,
        svgoPlugins: [{removeViewBox: false}],
        use: [pngcrush()]
      }))
    .pipe(gulp.dest(prod_path.images))
)

gulp.task('svg2png2x', ()->
  return gulp.src(dev_path.svg)
    .pipe(svg2png(2))
    .pipe(imagemin({
        progressive: true,
        svgoPlugins: [{removeViewBox: false}],
        use: [pngcrush()]
      }))
    .pipe(gulp.dest(prod_path.images2x))
)

gulp.task('svg2png', ['svg2png2x'], ()->
  return gulp.src(dev_path.svg)
    .pipe(svg2png())
    .pipe(imagemin({
        progressive: true,
        svgoPlugins: [{removeViewBox: false}],
        use: [pngcrush()]
      }))
    .pipe(gulp.dest(prod_path.images))
)

gulp.task('html', ()->
  return gulp.src(dev_path.jade)
    .pipe(jade())
    .pipe(prettify({indent_char: ' ', indent_size: 4}))
    # .pipe(w3cjs())
    # .pipe(htmlmin({collapseWhitespace: false}))
    .pipe(gulp.dest(prod_path.html))
)

gulp.task('stylus', ()->
  return gulp.src(dev_path.stylus)
    # .pipe(sourcemaps.init())
    .pipe(stylus())
    .pipe(concat('stylus.css'))
    # .pipe(sourcemaps.write())
    .pipe(gulp.dest(dev_path.css_tmp))
)

gulp.task('css', ['stylus'], ()->
  return gulp.src(dev_path.css)
    .pipe(prefix())
    .pipe(minifyCSS({removeEmpty:true}))
    # .pipe(cssbeautify())
    .pipe(concat('styles.css'))
    .pipe(gulp.dest(prod_path.css))
)

gulp.task('coffee', ()->
  return gulp.src(dev_path.coffee)
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())
    # .pipe(sourcemaps.init())
    .pipe(coffee({
      bare: true
      }))
    # .pipe(uglify())
    .pipe(esformatter({indent: {value: '  '}}))
    # .pipe(sourcemaps.write())
    .pipe(gulp.dest(prod_path.js))
)

gulp.task('js', ()->
  return gulp.src(dev_path.js)
    .pipe(sourcemaps.init())
    # .pipe(uglify())
    .pipe(esformatter({indent: {value: '  '}}))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(prod_path.js))
)


gulp.task('deploy', ()->
  ghpages.publish(path.join(__dirname, 'production'), {
      repo: 'git@github.com:SilentImp/soberimatras.ru.git',
      branch: 'gh-pages'
    }, (err)->
      if err
        throw err
      console.log('Published!')
  )
)


gulp.task('watch', ()->
  gulp.watch dev_path.svg,        ['svg']
  gulp.watch dev_path.fonts,      ['fonts']
  gulp.watch dev_path.jade,       ['html']
  gulp.watch dev_path.stylus,       ['css']
  gulp.watch dev_path.css,        ['css']
  gulp.watch dev_path.coffee,     ['coffee']
  gulp.watch dev_path.js,         ['js']
  gulp.watch dev_path.images,     ['images']
)

gulp.task 'default', ['dev', 'watch']
gulp.task 'dev', ['svg', 'fonts', 'html', 'css', 'coffee', 'js', 'images']

