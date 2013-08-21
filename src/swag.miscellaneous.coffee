Swag.addHelper 'default', (value, defaultValue) ->
    value ? defaultValue

Swag.addHelper 'partial', (name, data) ->
    partial = Swag.Config.partialsPath + name
    data = if Utils.isUndefined(data) then {} else data
    Swag.Handlebars.registerPartial(name, require partial) unless Swag.Handlebars.partials[name]?
    Utils.safeString Swag.Handlebars.partials[name](data)
