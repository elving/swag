Swag.registerHelper 'toFixed', (number, digits) ->
    digits = 0 if Utils.isUndefined(digits)
    number.toFixed digits

Swag.registerHelper 'toPrecision', (number, precision) ->
    precision = 1 if Utils.isUndefined(precision)
    number.toPrecision precision

Swag.registerHelper 'toExponential', (number, fractions) ->
    fractions = 0 if Utils.isUndefined(fractions)
    number.toExponential fractions

Swag.registerHelper 'toInt', (number) ->
    parseInt number, 10

Swag.registerHelper 'toFloat', (number) ->
    parseFloat number

Swag.registerHelper 'digitGrouping', (number, separator) ->
    separator = ',' if Utils.isUndefined(separator)
    number.toString().replace /(\d)(?=(\d\d\d)+(?!\d))/g, "$1#{separator}"
