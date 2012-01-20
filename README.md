# Introduction

[Hem](http://spinejs.com/docs/hem) is a project for compiling JavaScript
CommonJS modules. It acts as either a server, or a compiler for static
sites. Sometimes when using hem you would like to use Node.js to write
server logic. `connect-hem` provides the benefits of `hem` from within a
[connect](http://www.senchalabs.org/connect/) or
[express](http://expressjs.com) application
# Installation

    npm install connect-hem

# Usage

Example using express:

    hem = require('connect-hem');
    app = require('express').createServer();

    app.use(hem({
      jsPath: '/js/main.js',         // JavaScript ill be served at /js/main.js
      slug: __dirname + "/slug.json" // Load configuration from hem slug file
    }));

    app.listen(80);

The middleware builder takes one argument, `options`, which is an Object 
  * `jsPath`: The path which will seve the compiled JavaScript: Default: `'/applications.js'`
  * `slug`: Path to slug.json file. Default: `'./slug.json'`
  * `libs`: Array of additional static js files to include. Default: `[]`
  * `paths`: Array of paths to locations of your script files. Default: `['./app']`
  * `dependencies`: Array of depenent modules to include in your app.  Default: `[]`

If `slug` is defined, and it is `'./slug.json'` by default, the file
will be loaded, and any options in the slug will override any default
options or options passed to the middleware



# Running Tests

Install development dependencies
    npm --dev install

Run Tests

    cake test

To build js from coffee

    cake build

To build and run tests

    cake build test

