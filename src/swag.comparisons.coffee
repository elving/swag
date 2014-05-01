Swag.addHelper 'is', (value, test, options) ->
    value = Utils.result value
    test = Utils.result test
    if value and value is test then options.fn this else options.inverse this
, ['safe:string|number', 'safe:string|number']

Swag.addHelper 'isnt', (value, test, options) ->
    value = Utils.result value
    test = Utils.result test
    if not value or value isnt test then options.fn this else options.inverse this
, ['safe:string|number', 'safe:string|number']

Swag.addHelper 'gt', (value, test, options) ->
    value = Utils.result value
    test = Utils.result test
    if value > test then options.fn this else options.inverse this
, ['safe:string|number', 'safe:string|number']

Swag.addHelper 'gte', (value, test, options) ->
    value = Utils.result value
    test = Utils.result test
    if value >= test then options.fn this else options.inverse this
, ['safe:string|number', 'safe:string|number']

Swag.addHelper 'lt', (value, test, options) ->
    value = Utils.result value
    test = Utils.result test
    if value < test then options.fn this else options.inverse this
, ['safe:string|number', 'safe:string|number']

Swag.addHelper 'lte', (value, test, options) ->
    value = Utils.result value
    test = Utils.result test
    if value <= test then options.fn this else options.inverse this
, ['safe:string|number', 'safe:string|number']

Swag.addHelper 'or', (testA, testB, options) ->
    testA = Utils.result testA
    testB = Utils.result testB
    if testA or testB then options.fn this else options.inverse this
, ['safe:string|number', 'safe:string|number']

Swag.addHelper 'and', (testA, testB, options) ->
    testA = Utils.result testA
    testB = Utils.result testB
    if testA and testB then options.fn this else options.inverse this
, ['safe:string|number', 'safe:string|number']
