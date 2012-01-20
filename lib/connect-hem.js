(function() {
  var fs, package, path;

  package = require('hem/lib/package');

  fs = require('fs');

  path = require('path');

  module.exports = function(config) {
    var key, options, pkg, serveJavaScript, slugOptions, value;
    if (config == null) config = {};
    options = {
      jsPath: '/application.js',
      slug: './slug.json',
      libs: [],
      paths: ['./app'],
      dependencies: []
    };
    for (key in config) {
      value = config[key];
      options[key] = value;
    }
    if (options.slug && path.existsSync(options.slug)) {
      slugOptions = JSON.parse(fs.readFileSync(options.slug));
      for (key in slugOptions) {
        value = slugOptions[key];
        options[key] = value;
      }
    }
    pkg = package.createPackage(options);
    serveJavaScript = function(req, res, next) {
      var js;
      js = pkg.compile();
      res.writeHead(200, {
        'Content-Type': 'text/javascript',
        'Content-Length': js.length
      });
      return res.end(js);
    };
    return function(req, res, next) {
      if (req.method === 'GET' && req.path === options.jsPath) {
        return serveJavaScript(req, res, next);
      }
      return next();
    };
  };

}).call(this);
