Router.configure
  layoutTemplate: 'admin'
 
Router.route '/', {
  name: 'games'
}

Router.route '/admin', {
  name: 'admin'
}
 
Router.route '/teams', {
  name: 'teams'
}

Router.route '/walllog', {
  name: 'walllog'
}

Router.route '/scaffold', {
  name: 'scaffold'
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