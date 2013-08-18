Swag.registerHelper 'log', (value) ->
    console.log value

Swag.registerHelper 'debug', (value) ->
    console.log 'Context: ', @
    console.log('Value: ', value) unless Utils.isUndefined value
    console.log '-----------------------------------------------'
