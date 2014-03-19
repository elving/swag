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

Swag.addHelper 'toDuration', (value, humanize = true) ->
    unless Utils.isUndefined value
        if Utils.isString value
            duration = parseInt(value, 10)

        secondsInAMinute = 60
        secondsInAnHour = 60 * secondsInAMinute
        secondsInADay = 24 * secondsInAnHour

        days = Math.floor(value / secondsInADay)

        hoursSeconds = value % secondsInADay
        hours = Math.floor((value % secondsInADay) / secondsInAnHour)

        minuteSeconds = hoursSeconds % secondsInAnHour
        minutes = Math.floor(minuteSeconds / secondsInAMinute)

        seconds = Math.ceil(minuteSeconds % secondsInAMinute)

        if days > 0
            days = if days > 1 then "#{days} days, " else "#{days} day, "
        else
            days = ""

        if humanize
            hours = if (hours <= 0 or hours > 1) then "#{hours} hours, " else "#{hours} hour, "
            minutes = if (minutes <= 0 or minutes > 1) then "#{minutes} minutes, " else "#{minutes} minute, "
            seconds = if (seconds <= 0 or seconds > 1) then "#{seconds} seconds" else "#{seconds} second"
            "#{days}#{hours}#{minutes}#{seconds}"
        else
            hours = "0#{hours}" if hours < 10
            minutes = "0#{minutes}" if minutes < 10
            seconds = "0#{seconds}" if seconds < 10
            "#{days}#{hours}:#{minutes}:#{seconds}"
    else
        Utils.err '{{toDuration}} takes one argument (number|string).'

Swag.addHelper 'digitGrouping', (number, separator) ->
    unless Utils.isUndefined number
        number = parseFloat Utils.result number
        separator = if Utils.isUndefined separator then ',' else Utils.result separator
        number.toString().replace /(\d)(?=(\d\d\d)+(?!\d))/g, "$1#{separator}"
    else
        Utils.err '{{digitGrouping}} takes at least one argument (number).'
