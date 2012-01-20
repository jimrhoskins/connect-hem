{readdirSync} = require 'fs'
{print} = require 'util'
{spawn} = require 'child_process'

build = (callback) ->
  coffee = spawn 'coffee', ['-c', '-o', 'lib', 'src']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

test = (callback) ->
  mocha = spawn "#{__dirname}/node_modules/.bin/mocha", [
    "--reporter", "spec",
    "--colors",
    ("test/#{file}" for file in readdirSync('test') when file.match /\.coffee$/i)
  ] 
  mocha.stdout.pipe process.stdout, end: false
  mocha.stderr.pipe process.stderr, end: false
  mocha.on 'exit', (code) ->
    callback?() if code is 0

task 'build', 'Build lib/ from src/', ->
  build()

task 'test', 'Run tests', ->
  test()

