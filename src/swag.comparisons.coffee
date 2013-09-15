Swag.addHelper 'is', (value, test, options) ->
    if value is test then options.fn(@) else options.inverse(@)

Swag.addHelper 'isnt', (value, test, options) ->
    if value isnt test then options.fn(@) else options.inverse(@)

Swag.addHelper 'gt', (value, test, options) ->
    if value > test then options.fn(@) else options.inverse(@)

Swag.addHelper 'gte', (value, test, options) ->
    if value >= test then options.fn(@) else options.inverse(@)

Swag.addHelper 'lt', (value, test, options) ->
    if value < test then options.fn(@) else options.inverse(@)

Swag.addHelper 'lte', (value, test, options) ->
    if value <= test then options.fn(@) else options.inverse(@)

Swag.addHelper 'or', (testA, testB, options) ->
    if testA or testB then options.fn(@) else options.inverse(@)

Swag.addHelper 'and', (testA, testB, options) ->
    if testA and testB then options.fn(@) else options.inverse(@)
