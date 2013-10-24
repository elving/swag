Swag.addHelper 'log', (value) ->
    unless Utils.isUndefined value
        value = Utils.result value
        console.log value
    else
        Utils.err '{{log}} takes one arguments (string|number|boolean|array|object).'

Swag.addHelper 'debug', (value) ->
    value = Utils.result value unless Utils.isUndefined value
    console.log 'Context: ', this
    console.log 'Value: ', value unless Utils.isUndefined value
    console.log '-----------------------------------------------'
