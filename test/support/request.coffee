http = require 'http'

module.exports = request = (app) ->
  new Request(app)

class Request
  constructor: (@app) ->
    @headers = {}
    @data = []
    @server = @app 
    @method = 'get'
    @path = '/'
    @server.listen 0, =>
      @listening = true
      @addr = @server.address()

  request: (@method, @path) ->
    @

  end: (callback) ->
    unless @listening
      return @server.on 'listening', => @end(callback)

    req = http.request
      method: @method
      port: @addr.port
      host: @addr.address
      path: @path
      headers: @headers

    req

    req.on 'response', (res) =>
      buffer = ''
      res.setEncoding 'utf8'
      res.on 'data', (chunk) -> buffer += chunk
      res.on 'end', =>
        res.body = buffer
        callback(res)
        @server.close()
    
    req.end()
