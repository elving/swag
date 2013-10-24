Utils = {}

Utils.isUndefined = (value) ->
    (value is 'undefined' or value is null) or
    (value and value.fn?) or (value and value.hash?)

Utils.safeString = (str) ->
    new Swag.Handlebars.SafeString str

Utils.trim = (str) ->
    trim = if /\S/.test("\xA0") then /^[\s\xA0]+|[\s\xA0]+$/g else /^\s+|\s+$/g
    str.toString().replace trim, ''

Utils.isFunc = (value) ->
    typeof value is 'function'

Utils.result = (value) ->
    if Utils.isFunc value then value() else value

Utils.err = (msg) ->
    throw new Error msg
