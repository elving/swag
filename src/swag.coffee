###
    Swag v0.3.1 <http://elving.github.com/swag/>
    Copyright 2012 Elving Rodriguez <http://elving.me/>
    Available under MIT license <https://raw.github.com/elving/swag/master/LICENSE>
###

if window?
    window.Swag = Swag = {}

else if module?
    module.exports = Swag = {}

Swag.helpers = {}

Swag.addHelper = (name, helper) ->
    Swag.helpers[name] = helper

Swag.registerHelpers = (localHandlebars) ->
    if localHandlebars
        Swag.Handlebars = localHandlebars
    else
        if window?
            if window.Ember?
                Swag.Handlebars = Ember.Handlebars
            else
                Swag.Handlebars = window.Handlebars
        else if module?
            Swag.Handlebars = require 'handlebars'

    Swag.registerHelper = (name, helper) ->
        if window? and window.Ember
            Swag.Handlebars.helper name, helper
        else
            Swag.Handlebars.registerHelper name, helper

    for name, helper of Swag.helpers
        Swag.registerHelper name, helper
