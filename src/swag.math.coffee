Swag.addHelper 'add', (value, addition) ->
    value = parseFloat Utils.result value
    addition = parseFloat Utils.result addition
    value + addition
, ['number', 'number']

Swag.addHelper 'subtract', (value, substraction) ->
    value = parseFloat Utils.result value
    substraction = parseFloat Utils.result substraction
    value - substraction
, ['number', 'number']

Swag.addHelper 'divide', (value, divisor) ->
    value = parseFloat Utils.result value
    divisor = parseFloat Utils.result divisor
    value / divisor
, ['number', 'number']

Swag.addHelper 'multiply', (value, multiplier) ->
    value = parseFloat Utils.result value
    multiplier = parseFloat Utils.result multiplier
    value * multiplier
, ['number', 'number']

Swag.addHelper 'floor', (value) ->
    value = parseFloat Utils.result value
    Math.floor value
, 'number'

Swag.addHelper 'ceil', (value) ->
    value = parseFloat Utils.result value
    Math.ceil value
, 'number'

Swag.addHelper 'round', (value) ->
    value = parseFloat Utils.result value
    Math.round value
, 'number'
