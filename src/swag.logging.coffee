Swag.addHelper 'log', (value) ->
    console.log value
, 'string|number|boolean|array|object'

Swag.addHelper 'debug', (value) ->
    console.log 'Context: ', this
    console.log 'Value: ', value unless Utils.isUndefined value
    console.log '-----------------------------------------------'
