fs     = require 'fs'
path   = require 'path'
coffee = require 'coffee-script'
Mocha  = require 'mocha'
{ parser: jsp, uglify: pro } = require 'uglify-js'

task 'build', ->
    code  = ''
    files = [
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
    ]

    files.forEach (file) ->
        code += fs.readFileSync(file)

    code = coffee.compile(code)
    # code = pro.gen_code(
    #     pro.ast_squeeze(
    #         pro.ast_mangle(jsp.parse code)
    #     )
    # )

    fs.writeFile 'lib/swag.js', code

task 'test:collections', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'spec'
    )

    mocha.addFile('test/collections_test')

    mocha.run()
