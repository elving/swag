Swag.addHelper 'default', (value, defaultValue) ->
    unless (Utils.isHandlebarsSpecific value) and (Utils.isHandlebarsSpecific defaultValue)
        value = Utils.result value
        defaultValue = Utils.result defaultValue
        value ? defaultValue
    else
        Utils.err '{{default}} takes two arguments (string|number, string|number).'

Swag.addHelper 'partial', (name, template, data) ->
    if arguments.length is 2
        name = Utils.result name
        data = Utils.result template
        path = Swag.Config.partialsPath + name
    else if arguments.length is 3
        name = Utils.result name
        template = Utils.result template
        data = Utils.result data

    path = Swag.Config.partialsPath + name

    if Utils.isString name
        unless Swag.Handlebars.partials[name]?
            if define? and (Utils.isFunc define) and define.amd
                path = "!text#{path}" unless Swag.Config.precompiledTemplates
                require [path], (template) ->
                    Swag.Handlebars.registerPartial name, template
            else if require?
                Swag.Handlebars.registerPartial name, require path
            else if arguments.length is 3
                Swag.Handlebars.registerPartial name, template
            else
                Utils.err '{{partial}} no amd or commonjs module support found.'

        Utils.safeString Swag.Handlebars.partials[name](data)
    else
        Utils.err '{{partial}} the name argument must be a string.'

