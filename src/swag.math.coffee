Swag.registerHelper 'add', (value, addition) ->
    value + addition

Swag.registerHelper 'subtract', (value, substraction) ->
    value - substraction

Swag.registerHelper 'divide', (value, divisor) ->
    value / divisor

Swag.registerHelper 'multiply', (value, multiplier) ->
    value * multiplier

Swag.registerHelper 'floor', (value) ->
    Math.floor value

Swag.registerHelper 'ceil', (value) ->
    Math.ceil value

Swag.registerHelper 'round', (value) ->
    Math.round value
