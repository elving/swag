((exports) ->

    ###
    ----------------------------
    Config
    ----------------------------
    ###

    exports.Config =
        partialsPath: ''

    ###
    ----------------------------
    Utils
    ----------------------------
    ###

    Utils = {}

    Utils.toString = Object.prototype.toString

    Utils.isUndefined = (value) ->
        value is 'undefined' or Utils.toString.call(value) is '[object Function]' or value.hash?

    Utils.safeString = (str) ->
        new Handlebars.SafeString str

    Utils.trim = (str) ->
        trim = if /\S/.test("\xA0") then /^[\s\xA0]+|[\s\xA0]+$/g else /^\s+|\s+$/g
        str.toString().replace trim, ''

    ###
    ----------------------------
    Strings
    ----------------------------
    ###

    Handlebars.registerHelper 'lowercase', (str) ->
        str.toLowerCase()

    Handlebars.registerHelper 'uppercase', (str) ->
        str.toUpperCase()

    Handlebars.registerHelper 'capitalizeFirst', (str) ->
        str.charAt(0).toUpperCase() + str.slice(1)

    Handlebars.registerHelper 'capitalizeEach', (str) ->
        str.replace /\w\S*/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1)

    # Taken from Walrus titleize filter
    # https://github.com/jeremyruppel/walrus/blob/master/lib/walrus.strings.coffee#L89
    Handlebars.registerHelper 'titleize', (str) ->
        title = str.replace /[ \-_]+/g, ' '
        words = Utils.trim(title.replace /([A-Z])/g, " $&").split ' '
        capitalize = (word) -> word.charAt(0).toUpperCase() + word.slice(1)
        (capitalize word for word in words).join ' '

    Handlebars.registerHelper 'sentence', (str) ->
        str.replace /((?:\S[^\.\?\!]*)[\.\?\!]*)/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

    Handlebars.registerHelper 'reverse', (str) ->
        str.split('').reverse().join('')

    Handlebars.registerHelper 'truncate', (str, length, omission) ->
        omission = '' if Utils.isUndefined omission
        if str.length > length then str.substring(0, length - omission.length) + omission else str

    Handlebars.registerHelper 'center', (str, spaces) ->
        space = ''
        i = 0

        while i < spaces
            space += '&nbsp;'
            i++

        "#{space}#{str}#{space}"

    ###
    ----------------------------
    Collections
    ----------------------------
    ###

    Handlebars.registerHelper 'first', (array, count) ->
        if Utils.isUndefined(count) then array[0] else array.slice 0, count

    Handlebars.registerHelper 'withFirst', (array, count, options) ->
        if Utils.isUndefined count
            options = count
            options.fn array[0]
        else
            array = array.slice 0, count
            result = ''
            for item of array then result += options.fn array[item]
            result

    Handlebars.registerHelper 'last', (array, count) ->
        if Utils.isUndefined(count) then array[array.length - 1] else array.slice -count

    Handlebars.registerHelper 'withLast', (array, count, options) ->
        if Utils.isUndefined count
            options = count
            options.fn array[array.length - 1]
        else
            array = array.slice -count
            result = ''
            for item of array then result += options.fn array[item]
            result

    Handlebars.registerHelper 'after', (array, count) ->
        array.slice count

    Handlebars.registerHelper 'withAfter', (array, count, options) ->
        array = array.slice count
        result = ''
        for item of array then result += options.fn array[item]
        result

    Handlebars.registerHelper 'before', (array, count) ->
        array.slice 0, -count

    Handlebars.registerHelper 'withBefore', (array, count, options) ->
        array = array.slice 0, -count
        result = ''
        for item of array then result += options.fn array[item]
        result

    Handlebars.registerHelper 'join', (array, separator) ->
        array.join if Utils.isUndefined(separator) then ' ' else separator

    Handlebars.registerHelper 'sort', (array, field) ->
        if Utils.isUndefined field
            array.sort()
        else
            array.sort (a, b) -> a[field] > b[field]

    Handlebars.registerHelper 'withSort', (array, field, options) ->
        if Utils.isUndefined field
            options = field
            options.fn array.sort()
        else
            array = array.sort (a, b) -> a[field] > b[field]
            result = ''
            for item of array then result += options.fn array[item]
            result

    Handlebars.registerHelper 'length', (array) ->
        array.length

    Handlebars.registerHelper 'lengthEqual', (array, length, options) ->
        if array.length is length then options.fn(@) else options.inverse(@)

    Handlebars.registerHelper 'empty', (array, options) ->
        if array.length <= 0 then options.fn(@) else options.inverse(@)

    Handlebars.registerHelper 'any', (array, options) ->
        if array.length > 0 then options.fn(@) else options.inverse(@)

    Handlebars.registerHelper 'inArray', (array, value, options) ->
        if array.indexOf(value) isnt -1  then options.fn(@) else options.inverse(@)

    ###
    ----------------------------
    Math
    ----------------------------
    ###

    Handlebars.registerHelper 'add', (value, addition) ->
        value + addition

    Handlebars.registerHelper 'subtract', (value, substraction) ->
        value - substraction

    Handlebars.registerHelper 'divide', (value, divisor) ->
        value / divisor

    Handlebars.registerHelper 'multiply', (value, multiplier) ->
        value * multiplier

    Handlebars.registerHelper 'floor', (value) ->
        Math.floor value

    Handlebars.registerHelper 'ceil', (value) ->
        Math.ceil value

    Handlebars.registerHelper 'round', (value) ->
        Math.round value

    ###
    ----------------------------
    Comparisons
    ----------------------------
    ###

    Handlebars.registerHelper 'equal', (value, test, options) ->
        if value is test then options.fn(@) else options.inverse(@)

    Handlebars.registerHelper 'notEqual', (value, test, options) ->
        if value isnt test then options.fn(@) else options.inverse(@)

    Handlebars.registerHelper 'gt', (value, test, options) ->
        if value > test then options.fn(@) else options.inverse(@)

    Handlebars.registerHelper 'gte', (value, test, options) ->
        if value >= test then options.fn(@) else options.inverse(@)

    Handlebars.registerHelper 'lt', (value, test, options) ->
        if value < test then options.fn(@) else options.inverse(@)

    Handlebars.registerHelper 'lte', (value, test, options) ->
        if value <= test then options.fn(@) else options.inverse(@)

    ###
    ----------------------------
    Dates
    ----------------------------
    ###

    Dates = {}

    Dates.padNumber = (num, count, padCharacter) ->
        padCharacter = '0'  if typeof padCharacter is 'undefined'
        lenDiff = count - String(num).length
        padding = ''
        padding += padCharacter while lenDiff-- if lenDiff > 0
        padding + num

    Dates.dayOfYear = (date) ->
        oneJan = new Date(date.getFullYear(), 0, 1)
        Math.ceil (date - oneJan) / 86400000

    Dates.weekOfYear = (date) ->
        oneJan = new Date(date.getFullYear(), 0, 1)
        Math.ceil (((date - oneJan) / 86400000) + oneJan.getDay() + 1) / 7

    Dates.isoWeekOfYear = (date) ->
        target = new Date(date.valueOf())
        dayNr = (date.getDay() + 6) % 7
        target.setDate target.getDate() - dayNr + 3
        jan4 = new Date(target.getFullYear(), 0, 4)
        dayDiff = (target - jan4) / 86400000
        1 + Math.ceil(dayDiff / 7)

    Dates.tweleveHour = (date) ->
        if date.getHours() > 12 then date.getHours() - 12 else date.getHours()

    Dates.timeZoneOffset = (date) ->
        hoursDiff = (-date.getTimezoneOffset() / 60)
        result = Dates.padNumber Math.abs(hoursDiff), 4
        (if hoursDiff > 0 then '+' else '-') + result

    Dates.format = (date, format) ->
        format.replace Dates.formats, (m, p) ->
            switch p
                when 'a' then Dates.abbreviatedWeekdays[date.getDay()]
                when 'A' then Dates.fullWeekdays[date.getDay()]
                when 'b' then Dates.abbreviatedMonths[date.getMonth()]
                when 'B' then Dates.fullMonths[date.getMonth()]
                when 'c' then date.toLocaleString()
                when 'C' then Math.round date.getFullYear() / 100
                when 'd' then Dates.padNumber date.getDate(), 2
                when 'D' then Dates.format date, '%m/%d/%y'
                when 'e' then Dates.padNumber date.getDate(), 2, ' '
                when 'F' then Dates.format date, '%Y-%m-%d'
                when 'h' then Dates.format date, '%b'
                when 'H' then Dates.padNumber date.getHours(), 2
                when 'I' then Dates.padNumber Dates.tweleveHour(date), 2
                when 'j' then Dates.padNumber Dates.dayOfYear(date), 3
                when 'k' then Dates.padNumber date.getHours(), 2, ' '
                when 'l' then Dates.padNumber Dates.tweleveHour(date), 2, ' '
                when 'L' then Dates.padNumber date.getMilliseconds(), 3
                when 'm' then Dates.padNumber date.getMonth() + 1, 2
                when 'M' then Dates.padNumber date.getMinutes(), 2
                when 'n' then '\n'
                when 'p' then (if date.getHours() > 11 then 'PM' else 'AM')
                when 'P' then Dates.format(date, '%p').toLowerCase()
                when 'r' then Dates.format date, '%I:%M:%S %p'
                when 'R' then Dates.format date, '%H:%M'
                when 's' then date.getTime() / 1000
                when 'S' then Dates.padNumber date.getSeconds(), 2
                when 't' then '\t'
                when 'T' then Dates.format date, '%H:%M:%S'
                when 'u' then (if date.getDay() is 0 then 7 else date.getDay())
                when 'U' then Dates.padNumber Dates.weekOfYear(date), 2
                when 'v' then Dates.format date, '%e-%b-%Y'
                when 'V' then Dates.padNumber Dates.isoWeekOfYear(date), 2
                when 'W' then Dates.padNumber Dates.weekOfYear(date), 2
                when 'w' then Dates.padNumber date.getDay(), 2
                when 'x' then date.toLocaleDateString()
                when 'X' then date.toLocaleTimeString()
                when 'y' then String(date.getFullYear()).substring 2
                when 'Y' then date.getFullYear()
                when 'z' then Dates.timeZoneOffset date
                else match

    Dates.formats = /%(a|A|b|B|c|C|d|D|e|F|h|H|I|j|k|l|L|m|M|n|p|P|r|R|s|S|t|T|u|U|v|V|W|w|x|X|y|Y|z)/g
    Dates.abbreviatedWeekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat']
    Dates.fullWeekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    Dates.abbreviatedMonths = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    Dates.fullMonths = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

    # Port of formatDate-js library - https://github.com/michaelbaldry/formatDate-js
    Handlebars.registerHelper 'formatDate', (date, format) ->
        date = new Date date
        Dates.format date, format

    Handlebars.registerHelper 'now', (format) ->
        date = new Date()
        if Utils.isUndefined(format) then date else Dates.format(date, format)

    # Modified version of - http://stackoverflow.com/a/3177838
    Handlebars.registerHelper 'timeago', (date) ->
        date = new Date date
        seconds = Math.floor((new Date() - date) / 1000)

        interval = Math.floor(seconds / 31536000)
        return "#{interval} years ago" if interval > 1

        interval = Math.floor(seconds / 2592000)
        return if interval > 1 then "#{interval} months ago"

        interval = Math.floor(seconds / 86400)
        return if interval > 1 then "#{interval} days ago"

        interval = Math.floor(seconds / 3600)
        return if interval > 1 then "#{interval} hours ago"

        interval = Math.floor(seconds / 60)
        return if interval > 1 then "#{interval} minutes ago"

        if Math.floor(seconds) is 0 then 'Just now' else Math.floor(seconds) + ' seconds ago'

    ###
    ----------------------------
    Inflections
    ----------------------------
    ###

    Handlebars.registerHelper 'inflect', (count, singular, plural, include) ->
        word = if count > 1 or count is 0 then plural else singular
        if Utils.isUndefined(include) or include is false then word else "#{count} #{word}"

    # Taken from Walrus ordinalize filter
    # https://github.com/jeremyruppel/walrus/blob/master/lib/walrus.inflections.coffee#L156
    Handlebars.registerHelper 'ordinalize', (value) ->
        normal = Math.abs Math.round value

        if (normal % 100) in [11..13]
            "#{value}th"
        else
            switch normal % 10
                when 1 then "#{value}st"
                when 2 then "#{value}nd"
                when 3 then "#{value}rd"
                else "#{value}th"

    ###
    ----------------------------
    HTML
    ----------------------------
    ###

    HTML = {}

    HTML.parseAttributes = (hash) ->
        Object.keys(hash).map((key) ->
            "#{key}=\"#{hash[key]}\""
        ).join ' '

    Handlebars.registerHelper 'ul', (context, options) ->
        "<ul #{HTML.parseAttributes(options.hash)}>" + context.map((item) ->
            "<li>#{options.fn(item)}</li>"
        ).join('\n') + "</ul>"

    Handlebars.registerHelper 'ol', (context, options) ->
        "<ol #{HTML.parseAttributes(options.hash)}>" + context.map((item) ->
            "<li>#{options.fn(item)}</li>"
        ).join('\n') + "</ol>"

    Handlebars.registerHelper 'br', (count, options) ->
        br = '<br>'

        unless Utils.isUndefined count
            i = 0

            while i < count - 1
                br += '<br>'
                i++

        Utils.safeString br

    ###
    ----------------------------
    Logging
    ----------------------------
    ###

    Handlebars.registerHelper 'log', (value) ->
        console.log value

    Handlebars.registerHelper 'debug', (value) ->
        console.debug 'Context: ', @
        console.debug('Value: ', value) unless Utils.isUndefined value
        console.log '-----------------------------------------------'

    ###
    ----------------------------
    Misc
    ----------------------------
    ###

    Handlebars.registerHelper 'default', (value, defaultValue) ->
        newValue = value ? defaultValue
        if newValue then newValue else defaultValue

    Handlebars.registerHelper 'partial', (name, data) ->
        partial = name + exports.Config.partialsPath
        data = if Utils.isUndefined(data) then {} else data
        Handlebars.registerPartial(name, require partial) unless Handlebars.partials[name]?
        Utils.safeString Handlebars.partials[name](data)

) (if typeof exports is 'undefined' then @['Swag'] = {} else exports)
