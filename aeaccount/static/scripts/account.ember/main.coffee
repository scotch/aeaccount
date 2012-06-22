define [

  # jQuery
  'jquery'

  # Ember
  'lib/ember'
  'lib/ember-data'

  # Models
  'cs!account/models/user_profile'
  'cs!account/models/account'

  # Templates
  'text!account/templates/account/layout.hjs'
  'text!account/templates/account/overview.hjs'
  'text!account/templates/account/connected.hjs'
  'text!account/templates/account/profile.hjs'
  'text!account/templates/account/password.hjs'

  # helpers
  'cs!account/helpers'

#], ($, Em, DS, UserProfile) ->
], ($, Em, DS, UserProfile, Account, layoutTmpl, overviewTmpl, connectedTmpl, profileTmpl, passwordTmpl) ->

  # Register Templates
  Em.TEMPLATES['account-layout'] = Em.Handlebars.compile(layoutTmpl)
  Em.TEMPLATES['account-overview'] = Em.Handlebars.compile(overviewTmpl)
  Em.TEMPLATES['account-connected'] = Em.Handlebars.compile(connectedTmpl)
  Em.TEMPLATES['account-profile'] = Em.Handlebars.compile(profileTmpl)
  Em.TEMPLATES['account-password'] = Em.Handlebars.compile(passwordTmpl)

  if typeof String.prototype.startsWith != 'function'
    String.prototype.startsWith = (str) ->
      return @slice(0, str.length) == str

  if typeof String.prototype.endsWith != 'function'
    String.prototype.endsWith = (str) ->
      return @slice(-str.length) == str

  # Create App
  App = Em.Application.create
    VERSION: '0.0.1'

  # Setup Store
  App.store = DS.Store.create
    revision: 3
    adapter: DS.RESTAdapter.create(namespace: 'account/api/v1')

  ## Models ##
  App.UserProfile = UserProfile
  App.Account = Account

  App.userProfiles = App.store.find(App.UserProfile, { ownerIds: '1' })


  ## Controllers ##
  App.passwordController = Em.Object.create
    content: (->
#      pc = App.userProfiles
#      pc.filter( (item, index, self) ->
#        key = item.get('id')
#        if not key.startsWith('password')
#          a = item
#      )
      c = undefined
      for p in App.userProfiles
        key = p.get('id')
        if not key.startsWith('password')
          c = p
          break
      return c
#      return Ember.Object.create()
    #      return App.store.find(App.Config, 'application')
    ).property()

    hasPassword: (->
      if @content
        return true
      else
        return false
    ).property()

  App.masterProfiles = App.store.filter(App.UserProfile, (data) ->
      id = data.get('id')
      if id.startsWith('master')
        return true
  )
  App.masterProfileController = Em.Object.create
    content: (->
      return App.masterProfiles.get('firstObject')
    ).property()

  # Small LayoutState extension to toggle the navigation css
  NavState = Em.LayoutState.extend
    navSelector: '#account-nav'
    enter: (stateManager, transition) ->
      @_super(stateManager, transition)

      # Set the section header
      $header = $('#section-header')
      $header.html(@get('sectionTitle'))

      # Set the active item on the nav
      $nav = $(@get('navSelector'))
      $nav.children().removeClass('active')
      selector = @get('selector') || ("." + @get('path'))
      $nav.find(selector).addClass('active')

  # Register Layouts
  App.layout = Em.View.create
    templateName: 'account-layout'
#    classNames: ['.wrapper']

  # Index Layout View
  App.IndexLayoutView = Em.View.extend
    templateName: 'index'

  # Account Views
#  App.AccountLayoutView = Em.View.extend
#    templateName: 'account-layout'
#    create: (e)->
#      e.preventDefault()
#      console.log 'create clicked'
#      App.states.goToState('configs.detail')

  # List View
  App.OverviewLayoutView = Em.View.extend
    templateName: 'account-overview'
#    contentBinding: 'App.configs'
    detail: (e)->
      e.preventDefault()
      console.log 'Clicked entered showDetails'

  App.ConnectedLayoutView = Em.View.extend
    templateName: 'account-connected'
#    contentBinding: 'App.configs'
    detail: (e)->
      e.preventDefault()
      console.log 'Clicked entered showDetails'

  App.PasswordLayoutView = Em.View.extend
    templateName: 'account-password'
#    contentBinding: 'App.configs'

#  App.genderChoices = Em.A([
#    { value: 'male', label: 'Male' }
#    { value: 'female', label: 'Female' }
#    { value: 'other', label: 'Other' }
#  ])

#  App.selectedGenderController = Em.Object.create
#    genderBind: 'App.masterProfileController.content.gender'

  App.genderChoices = Em.A([
    'male'
    'female'
    'other'
  ])

  App.ProfileLayoutView = Em.View.extend
    templateName: 'account-profile'
    profileBinding: 'App.masterProfileController.content'
  # New Controller View
#  App.configNewController = App.store.createRecord(App.Config, {})

  # Create View
#  App.ConfigNewView = Em.View.extend
#    templateName: 'config-new'
#    nameBinding: 'App.configNewController.content.name'
#    descriptionBinding: 'App.configNewController.content.description'
#    priceBinding: 'App.configNewController.content.price'
#    save: (e)->
#      e.preventDefault()
#      console.log 'Clicked save'
#    cancel: (e)->
#      e.preventDefault()
#      console.log 'Clicked cancel'

  # Edit View
#  App.ConfigEditView = Em.View.extend
#    templateName: 'config-edit'
#    save: (e)->
#      e.preventDefault()
#      console.log 'Clicked save'
#    cancel: (e)->
#      e.preventDefault()
#      console.log 'Clicked cancel'

  # Detail View
#  App.ConfigShowView = Em.View.extend
#    templateName: 'config-show'

  # Route Manager
  App.routeManager = Em.RouteManager.create
    wantsHistory: false
    rootView: App.layout
    overview: NavState.create
      selector: '.overview'
      sectionTitle: 'Account Overview'
#      route: '/'
      viewClass: App.OverviewLayoutView

    connected: NavState.create
      selector: '.connected'
      sectionTitle: 'Connected Accounts'
      route: 'connected'
      viewClass: App.ConnectedLayoutView

    password: NavState.create
      selector: '.password'
      sectionTitle: 'Change Password'
      route: 'password'
      viewClass: App.PasswordLayoutView

    profile: NavState.create
      selector: '.profile'
      sectionTitle: 'Edit Your Profile'
      route: 'profile'
      viewClass: App.ProfileLayoutView

#      enter: (stateManager, transition) ->
#        @_super(stateManager, transition)
#        params = stateManager.get('params')
#        postId = params.id
#        console.log params

#    configs: Em.LayoutState.create
#      route: 'config'
#      viewClass: App.ConfigLayoutView
#
#      index: Em.LayoutState.create
#        viewClass: App.ConfigIndexView
#        enter: (stateManager, transition)->
#          @_super(stateManager, transition)
#          params = stateManager.get('params')
#
#      new: Em.LayoutState.create
#        route: 'new'
#        viewClass: App.ConfigNewView
#        enter: (stateManager, transition)->
#          @_super(stateManager, transition)
#          p = App.Config.create()
#          @get('view').set('content', p)
#
#      edit: Em.LayoutState.create
#        route: ':id'
#        viewClass: App.ConfigEditView
#        enter: (stateManager, transition)->
#          @_super(stateManager, transition)
#          params = stateManager.get('params')
#          configId = params.id
#
#          p = App.configs.get('firstObject')
#          if p
#            console.log "firstObject"
#            console.log(p.get('application_title'))
#          p = App.store.find(App.Config, configId)
#          if p
#            console.log(p.get('application_title'))
#          @get('view').set('content', p)

  App.layout.replaceIn '#content'
  return App
