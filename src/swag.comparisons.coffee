Swag.registerHelper 'is', (value, test, options) ->
    if value is test then options.fn(@) else options.inverse(@)

Swag.registerHelper 'isnt', (value, test, options) ->
    if value isnt test then options.fn(@) else options.inverse(@)

Swag.registerHelper 'gt', (value, test, options) ->
    if value > test then options.fn(@) else options.inverse(@)

Swag.registerHelper 'gte', (value, test, options) ->
    if value >= test then options.fn(@) else options.inverse(@)

Swag.registerHelper 'lt', (value, test, options) ->
    if value < test then options.fn(@) else options.inverse(@)

Swag.registerHelper 'lte', (value, test, options) ->
    if value <= test then options.fn(@) else options.inverse(@)

Swag.registerHelper 'or', (testA, testB, options) ->
    if testA or testB then options.fn(@) else options.inverse(@)

Swag.registerHelper 'and', (testA, testB, options) ->
    if testA and testB then options.fn(@) else options.inverse(@)
