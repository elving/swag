Swag.registerHelper 'lowercase', (str) ->
        str.toLowerCase()

Swag.registerHelper 'uppercase', (str) ->
    str.toUpperCase()

Swag.registerHelper 'capitalizeFirst', (str) ->
    str.charAt(0).toUpperCase() + str.slice(1)

Swag.registerHelper 'capitalizeEach', (str) ->
    str.replace /\w\S*/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1)

Swag.registerHelper 'titleize', (str) ->
    title = str.replace /[ \-_]+/g, ' '
    words = title.match(/\w+/g)
    capitalize = (word) -> word.charAt(0).toUpperCase() + word.slice(1)
    (capitalize word for word in words).join ' '

Swag.registerHelper 'sentence', (str) ->
    str.replace /((?:\S[^\.\?\!]*)[\.\?\!]*)/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

Swag.registerHelper 'reverse', (str) ->
    str.split('').reverse().join('')

Swag.registerHelper 'truncate', (str, length, omission) ->
    omission = '' if Utils.isUndefined omission
    if str.length > length then str.substring(0, length - omission.length) + omission else str

Swag.registerHelper 'center', (str, spaces) ->
    space = ''
    i = 0

    while i < spaces
        space += '&nbsp;'
        i++

    "#{space}#{str}#{space}"

Swag.registerHelper 'newLineToBr', (str) ->
    str.replace /\r?\n|\r/g, '<br>'
