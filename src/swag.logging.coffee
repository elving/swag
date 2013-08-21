Swag.addHelper 'log', (value) ->
    console.log value

Swag.addHelper 'debug', (value) ->
    console.log 'Context: ', @
    console.log('Value: ', value) unless Utils.isUndefined value
    console.log '-----------------------------------------------'
