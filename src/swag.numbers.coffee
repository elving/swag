Swag.addHelper 'toFixed', (number, digits) ->
    number = parseFloat Utils.result number
    digits = if Utils.isUndefined digits then 0 else Utils.result digits
    number.toFixed digits
, 'number'

Swag.addHelper 'toPrecision', (number, precision) ->
    number = parseFloat Utils.result number
    precision = if Utils.isUndefined precision then 1 else Utils.result precision
    number.toPrecision precision
, 'number'

Swag.addHelper 'toExponential', (number, fractions) ->
    number = parseFloat Utils.result number
    fractions = if Utils.isUndefined fractions then 0 else Utils.result fractions
    number.toExponential fractions
, 'number'

Swag.addHelper 'toInt', (number) ->
    number = Utils.result number
    parseInt number, 10
, 'number'

Swag.addHelper 'toFloat', (number) ->
    number = Utils.result number
    parseFloat number
, 'number'

Swag.addHelper 'digitGrouping', (number, separator) ->
    number = parseFloat Utils.result number
    separator = if Utils.isUndefined separator then ',' else Utils.result separator
    number.toString().replace /(\d)(?=(\d\d\d)+(?!\d))/g, "$1#{separator}"
, 'number'
