Swag.addHelper 'default', (value, defaultValue) ->
    unless (Utils.isUndefined value) and (Utils.isUndefined defaultValue)
        value = Utils.result value
        defaultValue = Utils.result defaultValue
        value ? defaultValue
    else
        Utils.err '{{default}} takes two arguments (string|number, string|number).'

Swag.addHelper 'partial', (name, data) ->
    data = if Utils.isUndefined(data) then {} else data
    partial = Swag.Config.partialsPath + name
    Swag.Handlebars.registerPartial(name, require partial) unless Swag.Handlebars.partials[name]?
    Utils.safeString Swag.Handlebars.partials[name](data)
