Swag.addHelper 'toFixed', (number, digits) ->
    number = parseFloat number
    digits = if Utils.isUndefined digits then 0 else digits
    number.toFixed digits
, 'number'

Swag.addHelper 'toPrecision', (number, precision) ->
    number = parseFloat number
    precision = if Utils.isUndefined precision then 1 else precision
    number.toPrecision precision
, 'number'

Swag.addHelper 'toExponential', (number, fractions) ->
    number = parseFloat number
    fractions = if Utils.isUndefined fractions then 0 else fractions
    number.toExponential fractions
, 'number'

Swag.addHelper 'toInt', (number) ->
    parseInt number, 10
, 'number'

Swag.addHelper 'toFloat', (number) ->
    parseFloat number
, 'number'

Swag.addHelper 'digitGrouping', (number, separator) ->
    number = parseFloat number
    separator = if Utils.isUndefined separator then ',' else separator
    number.toString().replace /(\d)(?=(\d\d\d)+(?!\d))/g, "$1#{separator}"
, 'number'
