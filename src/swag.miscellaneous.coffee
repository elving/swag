Handlebars.registerHelper 'default', (value, defaultValue) ->
    newValue = value ? defaultValue
    if newValue then newValue else defaultValue

Handlebars.registerHelper 'partial', (name, data) ->
    partial = Swag.Config.partialsPath + name
    data = if Utils.isUndefined(data) then {} else data
    Handlebars.registerPartial(name, require partial) unless Handlebars.partials[name]?
    Utils.safeString Handlebars.partials[name](data)
