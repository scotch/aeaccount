define [
  # Ember
  'lib/ember'
], (Em) ->
  Handlebars.registerHelper('favicon', (property) ->
    url = Ember.getPath(this, property)
    return new Handlebars.SafeString('<img width=16 height=16 src="https://s2.googleusercontent.com/s2/favicons?domain='+url+'" />')
  )
  Handlebars.registerHelper('titlecase', (property) ->
    string = Ember.getPath(this, property)
    return string.charAt(0).toUpperCase() + string.slice(1)
  )
#  Handlebars.registerHelper('img', (properties, width) ->
#    o = Ember.getPath(this, properties)
#    width = Ember.getPath(this, width)
#    console.log width
##    width = Ember.getPath(this, width)
##    height = Ember.getPath(this, height)
#    width = 30
#    height = 30
#    return new Handlebars.SafeString('<img width='+width+' height='+height+' src="'+url+'" />')
#  )
