require 'should'

Handlebars = require 'handlebars'
Swag = require '../lib/swag'

Swag.registerHelpers Handlebars

describe 'toFixed', ->
    describe '{{toFixed value}}', ->
        it 'should return the value rounded to the nearest integer.', ->
            source   = '{{toFixed value}}'
            template = Handlebars.compile(source)
            context  = value: 5.53231

            template(context).should.equal '6'

    describe '{{toFixed value 3}}', ->
        it 'should return the value rounded exactly n digits after the decimal place.', ->
            source   = '{{toFixed value 3}}'
            template = Handlebars.compile(source)
            context  = value: 5.53231

            template(context).should.equal '5.532'

describe 'toPrecision', ->
    describe '{{toPrecision value}}', ->
        it 'Returns the number in fixed-point or exponential notation rounded to n significant digits.', ->
            source   = '{{toPrecision value}}'
            template = Handlebars.compile(source)
            context  = value: 555.322

            template(context).should.equal '6e+2'

    describe '{{toPrecision value 4}}', ->
        it 'should return the value rounded exactly n digits after the decimal place.', ->
            source   = '{{toPrecision value 4}}'
            template = Handlebars.compile(source)
            context  = value: 555.322

            template(context).should.equal '555.3'

describe 'toExponential', ->
    describe '{{toExponential value}}', ->
        it 'should return the number in fixed-point or exponential notation rounded to n significant digits.', ->
            source   = '{{toExponential value}}'
            template = Handlebars.compile(source)
            context  = value: 5

            template(context).should.equal '5e+0'

    describe '{{toExponential value 5}}', ->
        it 'should return the number in fixed-point or exponential notation rounded to exactly n significant digits.', ->
            source   = '{{toExponential value 5}}'
            template = Handlebars.compile(source)
            context  = value: 5

            template(context).should.equal '5.00000e+0'

describe 'toInt', ->
    describe '{{toInt value}}', ->
        it 'should return an integer.', ->
            source   = '{{toInt value}}'
            template = Handlebars.compile(source)
            context  = value: '3cc'

            template(context).should.equal '3'

describe 'toFloat', ->
    describe '{{toFloat value}}', ->
        it 'should return a floating point number.', ->
            source   = '{{toFloat value}}'
            template = Handlebars.compile(source)
            context  = value: '3.1cc'

            template(context).should.equal '3.1'

describe 'toDuration', ->
    describe '{{toDuration value}}', ->
        it 'should return a <days> days, <hours> hours, <minutes> minutes, <seconds> seconds formatted string from an integer.', ->
            source   = '{{toDuration value}}'
            template = Handlebars.compile(source)
            context  = value: 131696

            template(context).should.equal '1 day, 12 hours, 34 minutes, 56 seconds'

    describe '{{toDuration value humanize}}', ->
        it 'should return a hours:minutes:seconds formatted string from a string representation of an integer.', ->
            source   = '{{toDuration value humanize}}'
            template = Handlebars.compile(source)
            context  = value: '3665', humanize: false

            template(context).should.equal '01:01:05'

describe 'digitGrouping', ->
    describe '{{digitGrouping value}}', ->
        it 'should add commas to a number.', ->
            source   = '{{digitGrouping value}}'
            template = Handlebars.compile(source)
            context  = value: 2222222

            template(context).should.equal '2,222,222'

    describe '{{digitGrouping value separator}}', ->
        it 'should add custom separator to a number.', ->
            source   = '{{digitGrouping value "-"}}'
            template = Handlebars.compile(source)
            context  = value: 2222222

            template(context).should.equal '2-222-222'
