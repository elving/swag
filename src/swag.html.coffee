HTML = {}

HTML.parseAttributes = (hash) ->
    Object.keys(hash).map((key) ->
        "#{key}=\"#{hash[key]}\""
    ).join ' '

Swag.addHelper 'ul', (context, options) ->
    "<ul #{HTML.parseAttributes(options.hash)}>" + context.map((item) ->
        "<li>#{options.fn(Utils.result item)}</li>"
    ).join('\n') + "</ul>"

Swag.addHelper 'ol', (context, options) ->
    "<ol #{HTML.parseAttributes(options.hash)}>" + context.map((item) ->
        "<li>#{options.fn(Utils.result item)}</li>"
    ).join('\n') + "</ol>"

Swag.addHelper 'br', (count, options) ->
    br = '<br>'

    unless Utils.isUndefined count
        i = 0

        while i < (parseFloat count) - 1
            br += '<br>'
            i++

    Utils.safeString br
