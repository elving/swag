fs = require 'fs'
path = require 'path'
Mocha = require 'mocha'
coffee = require 'coffee-script'
UglifyJS = require 'uglify-js'

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

    files.forEach (file) -> code += fs.readFileSync file

    code = coffee.compile code
    options =
        output:
            comments: yes
        fromString: yes

    minified_code = (UglifyJS.minify code, options).code

    fs.writeFile 'lib/swag.js', code
    fs.writeFile 'lib/swag.min.js', minified_code

task 'test:collections', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'spec'
    )

    mocha.addFile 'test/collections_test'

    mocha.run()

task 'test:math', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'spec'
    )

    mocha.addFile 'test/math_test'

    mocha.run()

task 'test:strings', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'spec'
    )

    mocha.addFile 'test/strings_test'

    mocha.run()

task 'test:comparisons', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'spec'
    )

    mocha.addFile 'test/comparisons_test'

    mocha.run()

task 'test:dates', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'spec'
    )

    mocha.addFile 'test/dates_test'

    mocha.run()

task 'test:inflections', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'spec'
    )

    mocha.addFile 'test/inflections_test'

    mocha.run()

task 'test:html', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'spec'
    )

    mocha.addFile 'test/html_test'

    mocha.run()

task 'test:logging', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'spec'
    )

    mocha.addFile 'test/logging_test'

    mocha.run()

task 'test:miscellaneous', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'spec'
    )

    mocha.addFile 'test/miscellaneous_test'

    mocha.run()

task 'test:numbers', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'spec'
    )

    mocha.addFile 'test/numbers_test'

    mocha.run()

task 'test', ->
    mocha = new Mocha(
        ui: 'bdd'
        reporter: 'min'
    )

    (fs.readdirSync 'test').forEach (file) ->
        mocha.addFile "test/#{file}" unless file is 'mocha.opts' or file is 'templates'

    mocha.run()

task 'build:test', ->
    invoke 'build'
    invoke 'test'
