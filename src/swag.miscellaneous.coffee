Swag.addHelper 'default', (value, defaultValue) ->
    unless (Utils.isHandlebarsSpecific value) and (Utils.isUndefined defaultValue)
        value = Utils.result value
        defaultValue = Utils.result defaultValue
        value or defaultValue
    else
        Utils.err '{{default}} takes two arguments (string|number, string|number).'

unless Ember?
    Swag.addHelper 'partial', (name, data, template) ->
        unless (Utils.isUndefined name)
            name = Utils.result name
            data = Utils.result data
            path = Swag.Config.partialsPath + name
            template = Utils.result template unless Utils.isUndefined template

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
        else
            Utils.err '{{partial}} takes at least one argument (string).'
