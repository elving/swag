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

# converts bytes into a nice representation with unit. e.g. 13661855 -> 13.7 MB, 825399 -> 825 KB, 1396 -> 1 KB
Handlebars.registerHelper 'friendlyBytes', (value) ->
    bytes = parseInt(value, 10)
    if bytes.toString() is 'NaN' 
      console.error "Handlebars helper friendlyBytes couldn't parse '#{value}'"
      return value
    metric = ['byte', 'bytes', 'KB', 'MB', 'GB'] # KB is technically a Kilobit, but it seems more readable. YOLO

    if bytes is 0
      resInt = resValue = 0
    else
      resInt = Math.floor(Math.log(bytes) / Math.log(1000)) # base 10 (rather than 1024) matches Mac OS X
      resValue = (bytes / Math.pow(1000, Math.floor(resInt))).toFixed(if resInt < 2 then 0 else 1) # no decimals for anything smaller than 1 MB 
      resInt = -1 if bytes is 1 # 1 byte special case
      
    return new Handlebars.SafeString( resValue + ' ' + metric[resInt + 1] )
