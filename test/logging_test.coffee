require 'should'

Handlebars = require 'handlebars'
Swag = require '../lib/swag'

# Add History to console.log
_log = if console then console.log else ->
_log.history = []

Swag.registerHelpers Handlebars

console.log = ->
    _log.history.push.apply(_log.history, arguments)
    _log.apply(console, arguments)

describe 'log', ->
    describe '{{log "Hi console :)"}}', ->
        it 'should log a message to the console.', ->
            source   = '{{log "Hi console :)"}}'
            template = Handlebars.compile(source)

            template()
            _log.history.should.include 'Hi console :)'

_log.history = []

describe 'debug', ->
    describe '{{debug value}}', ->
        it 'should log current context.', ->
            source   = '{{debug this}}'
            template = Handlebars.compile(source)
            context  = 'elving'

            template(context)
            _log.history.should.include 'elving'
