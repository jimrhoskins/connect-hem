jspackage   = require 'hem/lib/package'
csspackage  = require 'hem/lib/css'
fs          = require 'fs'
path        = require 'path'

module.exports = (config = {}) ->
  
  options = 
    jsPath:       '/application.js'
    cssPath:      '/application.css'
    cssFile:      './css/index.styl'
    slug:         './slug.json'
    libs:         []
    paths:        ['./app']
    dependencies: []

  # Load options from config
  options[key] = value for key, value of config

  # Load options from slug file
  if options.slug and path.existsSync options.slug
    slugOptions = JSON.parse(fs.readFileSync options.slug)
    options[key] = value for key, value of slugOptions

  # setup JS serving
  jspkg = jspackage.createPackage options
  serveJavaScript = (req, res, next) ->
    js = jspkg.compile()
    res.writeHead 200, 
      'Content-Type': 'text/javascript'
      'Content-Length': js.length
    res.end js
  
  # setup CSS serving
  csspkg = csspackage.createPackage options.cssFile
  serveCSS = (req, res, next) ->
    css = csspkg.compile()
    res.writeHead 200, 
      'Content-Type': 'text/css'
      'Content-Length': css.length
    res.end css

  # Middleware
  (req, res, next) ->
    if req.method is 'GET' and req.path is options.jsPath
      return serveJavaScript req, res, next
    if req.method is 'GET' and req.path is options.cssPath
      return serveCSS req, res, next
    next()
