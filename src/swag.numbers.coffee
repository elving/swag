Handlebars.registerHelper 'toFixed', (number, digits) ->
    number.toFixed if Utils.isUndefined(digits) then digits

Handlebars.registerHelper 'toPrecision', (number, precision) ->
    number.toPrecision if Utils.isUndefined(precision) then precision

Handlebars.registerHelper 'toExponential', (number, fractions) ->
    number.toExponential if Utils.isUndefined(fractions) then fractions

Handlebars.registerHelper 'toInt', (number) ->
    parseInt number, 10

Handlebars.registerHelper 'toFloat', (number) ->
    parseFloat number

Handlebars.registerHelper 'addCommas', (number) ->
    number.toString().replace /(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"
