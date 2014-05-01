Swag.addHelper 'lowercase', (str) ->
    str.toLowerCase()
, 'string'

Swag.addHelper 'uppercase', (str) ->
    str.toUpperCase()
, 'string'

Swag.addHelper 'capitalizeFirst', (str) ->
    str.charAt(0).toUpperCase() + str.slice(1)
, 'string'

Swag.addHelper 'capitalizeEach', (str) ->
    str.replace /\w\S*/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1)
, 'string'

Swag.addHelper 'titleize', (str) ->
    title = str.replace /[ \-_]+/g, ' '
    words = title.match(/\w+/g) || []
    capitalize = (word) -> word.charAt(0).toUpperCase() + word.slice(1)
    (capitalize word for word in words).join ' '
, 'string'

Swag.addHelper 'sentence', (str) ->
    str.replace /((?:\S[^\.\?\!]*)[\.\?\!]*)/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
, 'string'

Swag.addHelper 'reverse', (str) ->
    str.split('').reverse().join ''
, 'string'

Swag.addHelper 'truncate', (str, length, omission) ->
    omission = '' if Utils.isUndefined omission
    if str.length > length then str.substring(0, length - omission.length) + omission else str
, ['string', 'number']

Swag.addHelper 'center', (str, spaces) ->
    spaces = Utils.result spaces
    space = ''
    i = 0

    while i < spaces
        space += '&nbsp;'
        i++

    "#{space}#{str}#{space}"
, 'string'

Swag.addHelper 'newLineToBr', (str) ->
    str.replace /\r?\n|\r/g, '<br>'
, 'string'

Swag.addHelper 'sanitize', (str, replaceWith) ->
    replaceWith = '-' if Utils.isUndefined replaceWith
    str.replace /[^a-z0-9]/gi, replaceWith
, 'string'
