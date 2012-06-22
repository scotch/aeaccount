define [
  'lib/ember'
  'lib/ember-data'

], (Em, DS) ->

  return DS.Model.extend
    itemtype: DS.attr 'string'
    name: DS.attr 'string'
    description: DS.attr 'string'
    url: DS.attr 'string'

    provider: DS.attr 'string'
    updated: DS.attr 'string'
    image: DS.attr 'string'
    givenName: DS.attr 'string'
    familyName: DS.attr 'string'
    gender: DS.attr 'string'
    ownerIds: DS.hasMany('App.User', { embedded: true })
    accounts: DS.hasMany('App.Account', { embedded: true })
#    secret_key: DS.attr 'string'
#    default_from_email: DS.attr 'string'
#    cookie_max_age: DS.attr 'number'
#    cookie_domain: DS.attr 'string'
#    cookie_key: DS.attr 'string'
#    cookie_secure: DS.attr 'boolean'
#    cookie_path: DS.attr 'string'
#    cookie_httponly: DS.attr 'string'
#    user_model: DS.attr 'string'
#    title: DS.attr 'string'

    providerUrl: (->
      @get('provider') + ".com"
    ).property('provider')
