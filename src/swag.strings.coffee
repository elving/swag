Swag.addHelper 'lowercase', (str) ->
    str.toLowerCase()

Swag.addHelper 'uppercase', (str) ->
    str.toUpperCase()

Swag.addHelper 'capitalizeFirst', (str) ->
    str.charAt(0).toUpperCase() + str.slice(1)

Swag.addHelper 'capitalizeEach', (str) ->
    str.replace /\w\S*/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1)

Swag.addHelper 'titleize', (str) ->
    title = str.replace /[ \-_]+/g, ' '
    words = title.match(/\w+/g)
    capitalize = (word) -> word.charAt(0).toUpperCase() + word.slice(1)
    (capitalize word for word in words).join ' '

Swag.addHelper 'sentence', (str) ->
    str.replace /((?:\S[^\.\?\!]*)[\.\?\!]*)/g, (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

Swag.addHelper 'reverse', (str) ->
    str.split('').reverse().join('')

Swag.addHelper 'truncate', (str, length, omission) ->
    omission = '' if Utils.isUndefined omission
    if str.length > length then str.substring(0, length - omission.length) + omission else str

Swag.addHelper 'center', (str, spaces) ->
    space = ''
    i = 0

    while i < spaces
        space += '&nbsp;'
        i++

    "#{space}#{str}#{space}"

Swag.addHelper 'newLineToBr', (str) ->
    str.replace /\r?\n|\r/g, '<br>'
