Swag.addHelper 'lowercase', (str) ->
    Utils.verify 'lowercase', arguments, 'string'
    str = Utils.result str
    str.toLowerCase()

Swag.addHelper 'uppercase', (str) ->
    Utils.verify 'uppercase', arguments, 'string'
    str = Utils.result str
    str.toUpperCase()

Swag.addHelper 'capitalizeFirst', (str) ->
    Utils.verify 'capitalizeFirst', arguments, 'string'
    str = Utils.result str
    str.charAt(0).toUpperCase() + str.slice(1)

Swag.addHelper 'capitalizeEach', (str) ->
    Utils.verify 'capitalizeEach', arguments, 'string'
    str = Utils.result str
    str.replace /\w\S*/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1)

Swag.addHelper 'titleize', (str) ->
    Utils.verify 'titleize', arguments, 'string'
    str = Utils.result str
    title = str.replace /[ \-_]+/g, ' '
    words = title.match(/\w+/g)
    capitalize = (word) -> word.charAt(0).toUpperCase() + word.slice(1)
    (capitalize word for word in words).join ' '

Swag.addHelper 'sentence', (str) ->
    Utils.verify 'sentence', arguments, 'string'
    str = Utils.result str
    str.replace /((?:\S[^\.\?\!]*)[\.\?\!]*)/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

Swag.addHelper 'reverse', (str) ->
    Utils.verify 'reverse', arguments, 'string'
    str = Utils.result str
    str.split('').reverse().join ''

Swag.addHelper 'truncate', (str, length, omission) ->
    Utils.verify 'truncate', arguments, 'string', 'number'
    str = Utils.result str
    omission = '' if Utils.isUndefined omission
    if str.length > length then str.substring(0, length - omission.length) + omission else str

Swag.addHelper 'center', (str, spaces) ->
    Utils.verify 'center', arguments, 'string', 'number'
    str = Utils.result str
    spaces = Utils.result spaces
    space = ''
    i = 0

    while i < spaces
        space += '&nbsp;'
        i++

    "#{space}#{str}#{space}"

Swag.addHelper 'newLineToBr', (str) ->
    Utils.verify 'newLineToBr', arguments, 'string'
    str = Utils.result str
    str.replace /\r?\n|\r/g, '<br>'

Swag.addHelper 'sanitize', (str, replaceWith) ->
    Utils.verify 'sanitize', arguments, 'string'
    str = Utils.result str
    replaceWith = '-' if Utils.isUndefined replaceWith
    str.replace /[^a-z0-9]/gi, replaceWith
