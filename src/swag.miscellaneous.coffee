Swag.addHelper 'default', (value, defaultValue) ->
    value or defaultValue
, 'safe:string|number', 'string|number'

unless Ember?
    Swag.addHelper 'partial', (name, data, template) ->
        path = Swag.Config.partialsPath + name

        unless Swag.Handlebars.partials[name]?
            if !Utils.isUndefined template
                template = Swag.Handlebars.compile template if Utils.isString template
                Swag.Handlebars.registerPartial name, template
            else if define? and (Utils.isFunc define) and define.amd
                path = "!text#{path}" unless Swag.Config.precompiledTemplates
                require [path], (template) ->
                    template = Swag.Handlebars.compile template if Utils.isString template
                    Swag.Handlebars.registerPartial name, template
            else if require?
                template = require path
                template = Swag.Handlebars.compile template if Utils.isString template
                Swag.Handlebars.registerPartial name, template
            else
                Utils.err '{{partial}} no amd or commonjs module support found.'

        Utils.safeString Swag.Handlebars.partials[name] data
    , 'string'
