Swag.addHelper 'first', (array, count) ->
    unless Utils.isUndefined array
        array = Utils.result array
        count = parseFloat Utils.result count unless Utils.isUndefined count
        if Utils.isUndefined(count) then array[0] else array.slice 0, count
    else
        Utils.err '{{first}} takes at least one argument (array).'

Swag.addHelper 'withFirst', (array, count, options) ->
    unless Utils.isUndefined array
        array = Utils.result array
        count = parseFloat Utils.result count unless Utils.isUndefined count
        if Utils.isUndefined count
            options = count
            options.fn array[0]
        else
            array = array.slice 0, count
            result = ''
            for item of array then result += options.fn array[item]
            result
    else
        Utils.err '{{withFirst}} takes at least one argument (array).'

Swag.addHelper 'last', (array, count) ->
    unless Utils.isUndefined array
        array = Utils.result array
        count = parseFloat Utils.result count unless Utils.isUndefined count
        if Utils.isUndefined(count) then array[array.length - 1] else array.slice -count
    else
        Utils.err '{{last}} takes at least one argument (array).'

Swag.addHelper 'withLast', (array, count, options) ->
    unless Utils.isUndefined array
        array = Utils.result array
        count = parseFloat Utils.result count unless Utils.isUndefined count
        if Utils.isUndefined count
            options = count
            options.fn array[array.length - 1]
        else
            array = array.slice -count
            result = ''
            for item of array then result += options.fn array[item]
            result
    else
        Utils.err '{{withLast}} takes at least one argument (array).'

Swag.addHelper 'after', (array, count) ->
    unless (Utils.isUndefined array) and (Utils.isUndefined count)
        array = Utils.result array
        count = parseFloat Utils.result count unless Utils.isUndefined count
        array.slice count
    else
        Utils.err '{{after}} takes two arguments (array, number).'

Swag.addHelper 'withAfter', (array, count, options) ->
    unless (Utils.isUndefined array) and (Utils.isUndefined count)
        array = Utils.result array
        count = parseFloat Utils.result count unless Utils.isUndefined count
        array = array.slice count
        result = ''
        for item of array then result += options.fn array[item]
        result
    else
        Utils.err '{{withAfter}} takes two arguments (array, number).'

Swag.addHelper 'before', (array, count) ->
    unless (Utils.isUndefined array) and (Utils.isUndefined count)
        array = Utils.result array
        count = parseFloat Utils.result count unless Utils.isUndefined count
        array.slice 0, -count
    else
        Utils.err '{{before}} takes two arguments (array, number).'

Swag.addHelper 'withBefore', (array, count, options) ->
    unless (Utils.isUndefined array) and (Utils.isUndefined count)
        array = Utils.result array
        count = parseFloat Utils.result count unless Utils.isUndefined count
        array = array.slice 0, -count
        result = ''
        for item of array then result += options.fn array[item]
        result
    else
        Utils.err '{{withBefore}} takes two arguments (array, number).'

Swag.addHelper 'join', (array, separator) ->
    unless Utils.isUndefined array
        array = Utils.result array
        separator = Utils.result separator unless Utils.isUndefined separator
        array.join if Utils.isUndefined(separator) then ' ' else separator
    else
        Utils.err '{{join}} takes at least one argument (array).'

Swag.addHelper 'sort', (array, field) ->
    unless Utils.isUndefined array
        array = Utils.result array
        if Utils.isUndefined field
            array.sort()
        else
            field = Utils.result field
            array.sort (a, b) -> a[field] > b[field]
    else
        Utils.err '{{sort}} takes at least one argument (array).'

Swag.addHelper 'withSort', (array, field, options) ->
    unless Utils.isUndefined array
        array = Utils.result array
        result = ''

        if Utils.isUndefined field
            options = field
            array = array.sort()
            result += options.fn(item) for item in array
        else
            field = Utils.result field
            array = array.sort (a, b) -> a[field] > b[field]
            result += options.fn(array[item]) for item of array

        result
    else
        Utils.err '{{withSort}} takes at least one argument (array).'

Swag.addHelper 'length', (array) ->
    unless Utils.isUndefined array
        array = Utils.result array
        array.length
    else
        Utils.err '{{length}} takes one argument (array).'

Swag.addHelper 'lengthEqual', (array, length, options) ->
    unless Utils.isUndefined array
        array = Utils.result array
        length = parseFloat Utils.result length unless Utils.isUndefined length
        if array.length is length then options.fn this else options.inverse this
    else
        Utils.err '{{lengthEqual}} takes two arguments (array, number).'

Swag.addHelper 'empty', (array, options) ->
    unless Utils.isHandlebarsSpecific array
        array = Utils.result array
        if not array or array.length <= 0 then options.fn this else options.inverse this
    else
        Utils.err '{{empty}} takes one argument (array).'

Swag.addHelper 'any', (array, options) ->
    unless Utils.isHandlebarsSpecific array
        array = Utils.result array
        if array and array.length > 0 then options.fn this else options.inverse this
    else
        Utils.err '{{any}} takes one argument (array).'

Swag.addHelper 'inArray', (array, value, options) ->
    unless (Utils.isUndefined array) and (Utils.isUndefined value)
        array = Utils.result array
        value = Utils.result value
        if value in array then options.fn this else options.inverse this
    else
        Utils.err '{{inArray}} takes two arguments (array, string|number).'

Swag.addHelper 'eachIndex', (array, options) ->
    unless Utils.isUndefined array
        array = Utils.result array
        result = ''

        for value, index in array
            result += options.fn item: value, index: index

        result
    else
        Utils.err '{{eachIndex}} takes one argument (array).'

Swag.addHelper 'eachProperty', (obj, options) ->
    unless Utils.isUndefined obj
        obj = Utils.result obj
        result = ''

        for key, value of obj
            result += options.fn key: key, value: value

        result
    else
        Utils.err '{{eachProperty}} takes one argument (object).'
