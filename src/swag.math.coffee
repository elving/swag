Swag.addHelper 'add', (value, addition) ->
    value + addition

Swag.addHelper 'subtract', (value, substraction) ->
    value - substraction

Swag.addHelper 'divide', (value, divisor) ->
    value / divisor

Swag.addHelper 'multiply', (value, multiplier) ->
    value * multiplier

Swag.addHelper 'floor', (value) ->
    Math.floor value

Swag.addHelper 'ceil', (value) ->
    Math.ceil value

Swag.addHelper 'round', (value) ->
    Math.round value
