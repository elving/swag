###
    Swag v0.7.0 <http://elving.github.com/swag/>
    Copyright 2012 Elving Rodriguez <http://elving.me/>
    Available under MIT license <https://raw.github.com/elving/swag/master/LICENSE>
###

Swag = {}

# Export Swag for CommonJS. If being loaded as an AMD module, define it as such.
# Otherwise, just add `Swag` to the global object
if exports?
    if module? && module.exports?
        exports = module.exports = Swag
    exports.Swag = Swag
else if define? && define.amd?
    # Return the library as an AMD module:
    define [], () ->
        return Swag
else if window?
    # Otherwise expose Swag to the global object as usual
    window.Swag = Swag
else if module?
    # Expose Swag as module.exports in loaders that implement the Node
    # module pattern (including browserify). Do not create the global, since
    # the user will be storing it themselves locally, and globals are frowned
    # upon in the Node module world.
    module.exports = Swag

Swag.helpers = {}

Swag.addHelper = (name, helper, argTypes = []) ->
    unless argTypes instanceof Array
        argTypes = [argTypes]
    Swag.helpers[name] = ->
        # Verify all required arguments have been supplied
        Utils.verify name, arguments, argTypes

        # Call all arguments which are functions to get their result
        args = Array.prototype.slice.apply(arguments)
        resultArgs = []
        for arg in args
            unless Utils.isHandlebarsSpecific(arg)
                arg = Utils.result(arg)
            resultArgs.push(arg)
        helper.apply @, resultArgs

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
