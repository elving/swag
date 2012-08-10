fs = require 'fs'
coffee = require 'coffee-script'
{ parser: jsp, uglify: pro } = require 'uglify-js'

task 'build', ->
    code = ''
    [
        'src/swag.coffee'
        'src/swag.config.coffee'
        'src/swag.utils.coffee'
        'src/swag.strings.coffee'
        'src/swag.collections.coffee'
        'src/swag.math.coffee'
        'src/swag.numbers.coffee'
        'src/swag.comparisons.coffee'
        'src/swag.dates.coffee'
        'src/swag.inflections.coffee'
        'src/swag.html.coffee'
        'src/swag.logging.coffee'
        'src/swag.miscellaneous.coffee'
    ].forEach (file) -> code += fs.readFileSync(file)
    code = coffee.compile code
    code = pro.gen_code pro.ast_squeeze pro.ast_mangle jsp.parse code
    fs.writeFile 'lib/swag.js', code



