package = require 'hem/lib/package'
fs = require 'fs'
path = require 'path'

module.exports = (config = {}) ->
  
  options = 
    jsPath: '/application.js'
    slug:   './slug.json'
    libs:   []
    paths:  ['./app']
    dependencies: []

  # Load options from config
  options[key] = value for key, value of config

  # Load options from slug file
  if options.slug and path.existsSync options.slug
    slugOptions = JSON.parse(fs.readFileSync options.slug)
    options[key] = value for key, value of slugOptions

  pkg = package.createPackage options

  serveJavaScript = (req, res, next) ->
    js = pkg.compile()
    res.writeHead 200, 
      'Content-Type': 'text/javascript'
      'Content-Length': js.length
    res.end js


  # Middleware
  (req, res, next) ->
    if req.method is 'GET' and req.path is options.jsPath
      return serveJavaScript req, res, next
    next()



