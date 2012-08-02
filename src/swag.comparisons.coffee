Handlebars.registerHelper 'equal', (value, test, options) ->
    if value is test then options.fn(@) else options.inverse(@)

Handlebars.registerHelper 'notEqual', (value, test, options) ->
    if value isnt test then options.fn(@) else options.inverse(@)

Handlebars.registerHelper 'gt', (value, test, options) ->
    if value > test then options.fn(@) else options.inverse(@)

Handlebars.registerHelper 'gte', (value, test, options) ->
    if value >= test then options.fn(@) else options.inverse(@)

Handlebars.registerHelper 'lt', (value, test, options) ->
    if value < test then options.fn(@) else options.inverse(@)

Handlebars.registerHelper 'lte', (value, test, options) ->
    if value <= test then options.fn(@) else options.inverse(@)
