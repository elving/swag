Handlebars.registerHelper 'log', (value) ->
    console.log value

Handlebars.registerHelper 'debug', (value) ->
    console.debug 'Context: ', @
    console.debug('Value: ', value) unless Utils.isUndefined value
    console.log '-----------------------------------------------'
