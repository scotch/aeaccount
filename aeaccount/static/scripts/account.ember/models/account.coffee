#
# Account
#
define [
  'lib/ember'
  'lib/ember-data'

], (Em, DS) ->

  return DS.Model.extend
    itemtype: DS.attr 'string'
    name: DS.attr 'string'
    description: DS.attr 'string'
    image: DS.attr 'string'
    url: DS.attr 'string'
    userid: DS.attr 'string'
    username: DS.attr 'string'
