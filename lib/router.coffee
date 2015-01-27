Router.configure
  layoutTemplate: 'layout'
 
Router.route '/', {
  name: 'teams'
  layoutTemplate: 'walllog'
}

Router.route '/admin', {
  name: 'wallpapers'
  layoutTemplate: 'layout'
  action: ->
    unless Meteor.user()
      @render "login"
    else
      @render "wallpapers"
}

Router.route '/games', {
  name: 'games'
}

 
requireLogin = ->
  if !Meteor.user()
    if Meteor.loggingIn()
      # We could render a loading template here
    else
      @render('accessDenied')
  	  @next()
  else
    @next()
 
Router.onBeforeAction(requireLogin)