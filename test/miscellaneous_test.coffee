require 'should'

Handlebars = require 'handlebars'
Swag = require '../lib/swag'

Swag.registerHelpers Handlebars

describe 'default', ->
    describe '{{default title "Not title available."}}', ->
        it 'should provide a default or fallback value if a value doesn\'t exist.', ->
            source   = '{{default title "No title available."}}'
            template = Handlebars.compile(source)
            context  = title: null

            template(context).should.equal 'No title available.'

Swag.Config.partialsPath = '../test/templates/'

describe 'partial', ->
    describe '{{partial "some_template"}}', ->
        it 'should register and render a partial.', ->
            source   = '{{partial "some_template"}}'
            template = Handlebars.compile(source)

            template().should.equal 'A partial.'
