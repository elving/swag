Swag.addHelper 'first', (array, count) ->
    count = parseFloat count unless Utils.isUndefined count
    if Utils.isUndefined(count) then array[0] else array.slice 0, count
, 'array'

Swag.addHelper 'withFirst', (array, count, options) ->
    count = parseFloat count unless Utils.isUndefined count
    if Utils.isUndefined count
        options = count
        options.fn array[0]
    else
        array = array.slice 0, count
        result = ''
        for item of array then result += options.fn array[item]
        result
, 'array'

Swag.addHelper 'last', (array, count) ->
    count = parseFloat count unless Utils.isUndefined count
    if Utils.isUndefined(count) then array[array.length - 1] else array.slice -count
, 'array'

Swag.addHelper 'withLast', (array, count, options) ->
    count = parseFloat count unless Utils.isUndefined count
    if Utils.isUndefined count
        options = count
        options.fn array[array.length - 1]
    else
        array = array.slice -count
        result = ''
        for item of array then result += options.fn array[item]
        result
, 'array'

Swag.addHelper 'after', (array, count) ->
    count = parseFloat count unless Utils.isUndefined count
    array.slice count
, ['array', 'number']

Swag.addHelper 'withAfter', (array, count, options) ->
    count = parseFloat count unless Utils.isUndefined count
    array = array.slice count
    result = ''
    for item of array then result += options.fn array[item]
    result
, ['array', 'number']

Swag.addHelper 'before', (array, count) ->
    count = parseFloat count unless Utils.isUndefined count
    array.slice 0, -count
, ['array', 'number']

Swag.addHelper 'withBefore', (array, count, options) ->
    count = parseFloat count unless Utils.isUndefined count
    array = array.slice 0, -count
    result = ''
    for item of array then result += options.fn array[item]
    result
, ['array', 'number']

Swag.addHelper 'join', (array, separator) ->
    array.join if Utils.isUndefined(separator) then ' ' else separator
, 'array'

Swag.addHelper 'sort', (array, field) ->
    if Utils.isUndefined field
        array.sort()
    else
        array.sort (a, b) -> a[field] > b[field]
, 'array'

Swag.addHelper 'withSort', (array, field, options) ->
    result = ''

    if Utils.isUndefined field
        options = field
        array = array.sort()
        result += options.fn(item) for item in array
    else
        array = array.sort (a, b) -> a[field] > b[field]
        result += options.fn(array[item]) for item of array

    result
, 'array'

Swag.addHelper 'length', (array) ->
    array.length
, 'array'

Swag.addHelper 'lengthEqual', (array, length, options) ->
    length = parseFloat length unless Utils.isUndefined length
    if array.length is length then options.fn this else options.inverse this
, ['array', 'number']

Swag.addHelper 'empty', (array, options) ->
    if not array or array.length <= 0 then options.fn this else options.inverse this
, 'safe:array'

Swag.addHelper 'any', (array, options) ->
    if array and array.length > 0 then options.fn this else options.inverse this
, 'safe:array'

Swag.addHelper 'inArray', (array, value, options) ->
    if value in array then options.fn this else options.inverse this
, ['array', 'string|number']

Swag.addHelper 'eachIndex', (array, options) ->
    result = ''

    for value, index in array
        result += options.fn item: value, index: index

    result
, 'array'

Swag.addHelper 'eachProperty', (obj, options) ->
    result = ''

    for key, value of obj
        result += options.fn key: key, value: value

    result
, 'object'
