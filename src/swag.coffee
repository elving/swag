###
    Swag v0.1.9 <http://elving.github.com/swag/>
    Copyright 2012 Elving Rodriguez <http://elving.me/>
    Available under MIT license <https://raw.github.com/elving/swag/master/LICENSE>
###

if window?
    Handlebars = window.Handlebars
    window.Swag = Swag = {}
if module?
    Handlebars = require 'handlebars'
    module.exports = Swag = {}
