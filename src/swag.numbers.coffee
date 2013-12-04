Swag.addHelper 'toFixed', (number, digits) ->
    unless Utils.isUndefined number
        number = parseFloat Utils.result number
        digits = if Utils.isUndefined digits then 0 else Utils.result digits
        number.toFixed digits
    else
        Utils.err '{{toFixed}} takes at least one argument (number).'

Swag.addHelper 'toPrecision', (number, precision) ->
    unless Utils.isUndefined number
        number = parseFloat Utils.result number
        precision = if Utils.isUndefined precision then 1 else Utils.result precision
        number.toPrecision precision
    else
        Utils.err '{{toPrecision}} takes at least one argument (number).'

Swag.addHelper 'toExponential', (number, fractions) ->
    unless Utils.isUndefined number
        number = parseFloat Utils.result number
        fractions = if Utils.isUndefined fractions then 0 else Utils.result fractions
        number.toExponential fractions
    else
        Utils.err '{{toExponential}} takes at least one argument (number).'

Swag.addHelper 'toInt', (number) ->
    unless Utils.isUndefined number
        number = Utils.result number
        parseInt number, 10
    else
        Utils.err '{{toInt}} takes one argument (number).'

Swag.addHelper 'toFloat', (number) ->
    unless Utils.isUndefined number
        number = Utils.result number
        parseFloat number
    else
        Utils.err '{{toFloat}} takes one argument (number).'

Swag.addHelper 'digitGrouping', (number, separator) ->
    unless Utils.isUndefined number
        number = parseFloat Utils.result number
        separator = if Utils.isUndefined separator then ',' else Utils.result separator
        number.toString().replace /(\d)(?=(\d\d\d)+(?!\d))/g, "$1#{separator}"
    else
        Utils.err '{{digitGrouping}} takes at least one argument (number).'

Swag.addHelper 'toOrdinal', (number) ->
    unless Utils.isUndefined number
        number = parseInt Utils.result number
        b = number % 10;
        number + (if Math.floor(number % 100 / 10) is 1 then 'th'
        else switch b
            when 1 then 'st'
            when 2 then 'nd'
            when 3 then 'rd'
            else 'th')
    else
        Utils.err '{{toOrdinal}} takes at least one argument (number).'

;

