Handlebars = require 'handlebars'

module.exports = Handlebars.template (Handlebars, depth0, helpers, partials, data) ->
    revision = Handlebars.COMPILER_REVISION
    versions = Handlebars.REVISION_CHANGES[revision]
    this.compilerInfo = [revision,versions]
    helpers = helpers or Handlebars.helpers
    foundHelper = undefined
    self = this
    'A partial.'
