Swag.addHelper 'toFixed', (number, digits) ->
    digits = 0 if Utils.isUndefined(digits)
    number.toFixed digits

Swag.addHelper 'toPrecision', (number, precision) ->
    precision = 1 if Utils.isUndefined(precision)
    number.toPrecision precision

Swag.addHelper 'toExponential', (number, fractions) ->
    fractions = 0 if Utils.isUndefined(fractions)
    number.toExponential fractions

Swag.addHelper 'toInt', (number) ->
    parseInt number, 10

Swag.addHelper 'toFloat', (number) ->
    parseFloat number

Swag.addHelper 'digitGrouping', (number, separator) ->
    separator = ',' if Utils.isUndefined(separator)
    number.toString().replace /(\d)(?=(\d\d\d)+(?!\d))/g, "$1#{separator}"
