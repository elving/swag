Swag.addHelper 'is', (value, test, options) ->
    unless (Utils.isHandlebarsSpecific value) and (Utils.isHandlebarsSpecific value)
        value = Utils.result value
        test = Utils.result test
        if value and value is test then options.fn this else options.inverse this
    else
        Utils.err '{{is}} takes two arguments (string|number, string|number).'

Swag.addHelper 'isnt', (value, test, options) ->
    unless (Utils.isHandlebarsSpecific value) and (Utils.isHandlebarsSpecific test)
        value = Utils.result value
        test = Utils.result test
        if not value or value isnt test then options.fn this else options.inverse this
    else
        Utils.err '{{isnt}} takes two arguments (string|number, string|number).'

Swag.addHelper 'gt', (value, test, options) ->
    unless (Utils.isHandlebarsSpecific value) and (Utils.isHandlebarsSpecific test)
        value = Utils.result value
        test = Utils.result test
        if value > test then options.fn this else options.inverse this
    else
        Utils.err '{{gt}} takes two arguments (string|number, string|number).'

Swag.addHelper 'gte', (value, test, options) ->
    unless (Utils.isHandlebarsSpecific value) and (Utils.isHandlebarsSpecific test)
        value = Utils.result value
        test = Utils.result test
        if value >= test then options.fn this else options.inverse this
    else
        Utils.err '{{gte}} takes two arguments (string|number, string|number).'

Swag.addHelper 'lt', (value, test, options) ->
    unless (Utils.isHandlebarsSpecific value) and (Utils.isHandlebarsSpecific test)
        value = Utils.result value
        test = Utils.result test
        if value < test then options.fn this else options.inverse this
    else
        Utils.err '{{lt}} takes two arguments (string|number, string|number).'

Swag.addHelper 'lte', (value, test, options) ->
    unless (Utils.isHandlebarsSpecific value) and (Utils.isHandlebarsSpecific test)
        value = Utils.result value
        test = Utils.result test
        if value <= test then options.fn this else options.inverse this
    else
        Utils.err '{{lte}} takes two arguments (string|number, string|number).'

Swag.addHelper 'or', (testA, testB, options) ->
    unless (Utils.isHandlebarsSpecific testA) and (Utils.isHandlebarsSpecific testB)
        testA = Utils.result testA
        testB = Utils.result testB
        if testA or testB then options.fn this else options.inverse this
    else
        Utils.err '{{or}} takes two arguments (string|number, string|number).'

Swag.addHelper 'and', (testA, testB, options) ->
    unless (Utils.isHandlebarsSpecific testA) and (Utils.isHandlebarsSpecific testB)
        testA = Utils.result testA
        testB = Utils.result testB
        if testA and testB then options.fn this else options.inverse this
    else
        Utils.err '{{and}} takes two arguments (string|number, string|number).'
