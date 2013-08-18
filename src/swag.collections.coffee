Swag.registerHelper 'first', (array, count) ->
    if Utils.isUndefined(count) then array[0] else array.slice 0, count

Swag.registerHelper 'withFirst', (array, count, options) ->
    if Utils.isUndefined count
        options = count
        options.fn array[0]
    else
        array = array.slice 0, count
        result = ''
        for item of array then result += options.fn array[item]
        result

Swag.registerHelper 'last', (array, count) ->
    if Utils.isUndefined(count) then array[array.length - 1] else array.slice -count

Swag.registerHelper 'withLast', (array, count, options) ->
    if Utils.isUndefined count
        options = count
        options.fn array[array.length - 1]
    else
        array = array.slice -count
        result = ''
        for item of array then result += options.fn array[item]
        result

Swag.registerHelper 'after', (array, count) ->
    array.slice count

Swag.registerHelper 'withAfter', (array, count, options) ->
    array = array.slice count
    result = ''
    for item of array then result += options.fn array[item]
    result

Swag.registerHelper 'before', (array, count) ->
    array.slice 0, -count

Swag.registerHelper 'withBefore', (array, count, options) ->
    array = array.slice 0, -count
    result = ''
    for item of array then result += options.fn array[item]
    result

Swag.registerHelper 'join', (array, separator) ->
    array.join if Utils.isUndefined(separator) then ' ' else separator

Swag.registerHelper 'sort', (array, field) ->
    if Utils.isUndefined field
        array.sort()
    else
        array.sort (a, b) -> a[field] > b[field]

Swag.registerHelper 'withSort', (array, field, options) ->
    result = ''

    if Utils.isUndefined field
        options = field
        array = array.sort()
        result += options.fn(item) for item in array
    else
        array = array.sort (a, b) -> a[field] > b[field]
        result += options.fn(array[item]) for item of array

    result

Swag.registerHelper 'length', (array) ->
    array.length

Swag.registerHelper 'lengthEqual', (array, length, options) ->
    if array.length is length then options.fn(@) else options.inverse(@)

Swag.registerHelper 'empty', (array, options) ->
    if array.length <= 0 then options.fn(@) else options.inverse(@)

Swag.registerHelper 'any', (array, options) ->
    if array.length > 0 then options.fn(@) else options.inverse(@)

Swag.registerHelper 'inArray', (array, value, options) ->
    if value in array then options.fn(@) else options.inverse(@)

Swag.registerHelper 'eachIndex', (array, options) ->
    result = ''

    for value, index in array
        result += options.fn item: value, index: index

    result

Swag.registerHelper 'eachProperty', (obj, options) ->
    result = ''

    for key, value of obj
        result += options.fn key: key, value: value

    result
