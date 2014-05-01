Swag.addHelper 'add', (value, addition) ->
    value = parseFloat value
    addition = parseFloat addition
    value + addition
, ['number', 'number']

Swag.addHelper 'subtract', (value, substraction) ->
    value = parseFloat value
    substraction = parseFloat substraction
    value - substraction
, ['number', 'number']

Swag.addHelper 'divide', (value, divisor) ->
    value = parseFloat value
    divisor = parseFloat divisor
    value / divisor
, ['number', 'number']

Swag.addHelper 'multiply', (value, multiplier) ->
    value = parseFloat value
    multiplier = parseFloat multiplier
    value * multiplier
, ['number', 'number']

Swag.addHelper 'floor', (value) ->
    value = parseFloat value
    Math.floor value
, 'number'

Swag.addHelper 'ceil', (value) ->
    value = parseFloat value
    Math.ceil value
, 'number'

Swag.addHelper 'round', (value) ->
    value = parseFloat value
    Math.round value
, 'number'
