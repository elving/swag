###
    Swag v0.2.8 <http://elving.github.com/swag/>
    Copyright 2012 Elving Rodriguez <http://elving.me/>
    Available under MIT license <https://raw.github.com/elving/swag/master/LICENSE>
###

if window?
    Handlebars = window.Handlebars
    window.Swag = Swag = {}
    Swag.registerHelper = ->
        if window.Ember
            Ember.Handlebars.helper arguments
        else
            Handlebars.registerHelper arguments

if module?
    Handlebars = require 'handlebars'
    module.exports = Swag = {}
    Swag.registerHelper = ->
        Handlebars.registerHelper arguments
