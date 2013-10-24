Swag.addHelper 'add', (value, addition) ->
    unless (Utils.isUndefined value) and (Utils.isUndefined addition)
        value = parseFloat Utils.result value
        addition = parseFloat Utils.result addition
        value + addition
    else
        Utils.err '{{add}} takes two arguments (number, number).'

Swag.addHelper 'subtract', (value, substraction) ->
    unless (Utils.isUndefined value) and (Utils.isUndefined substraction)
        value = parseFloat Utils.result value
        substraction = parseFloat Utils.result substraction
        value - substraction
    else
        Utils.err '{{subtract}} takes two arguments (number, number).'

Swag.addHelper 'divide', (value, divisor) ->
    unless (Utils.isUndefined value) and (Utils.isUndefined divisor)
        value = parseFloat Utils.result value
        divisor = parseFloat Utils.result divisor
        value / divisor
    else
        Utils.err '{{divide}} takes two arguments (number, number).'

Swag.addHelper 'multiply', (value, multiplier) ->
    unless (Utils.isUndefined value) and (Utils.isUndefined multiplier)
        value = parseFloat Utils.result value
        multiplier = parseFloat Utils.result multiplier
        value * multiplier
    else
        Utils.err '{{multiply}} takes two arguments (number, number).'

Swag.addHelper 'floor', (value) ->
    unless (Utils.isUndefined value)
        value = parseFloat Utils.result value
        Math.floor value
    else
        Utils.err '{{floor}} takes one argument (number).'

Swag.addHelper 'ceil', (value) ->
    unless (Utils.isUndefined value)
        value = parseFloat Utils.result value
        Math.ceil value
    else
        Utils.err '{{ceil}} takes one argument (number).'

Swag.addHelper 'round', (value) ->
    unless (Utils.isUndefined value)
        value = parseFloat Utils.result value
        Math.round value
    else
        Utils.err '{{round}} takes one argument (number).'
