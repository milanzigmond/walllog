Router.configure
  layoutTemplate: 'layout'
 
Router.route '/', {
  name: 'teams'
  layoutTemplate: 'walllog'
}

Router.route '/admin', {
  name: 'admin'
  layoutTemplate: 'layout'
  action: ->
    unless Meteor.user()
      @render "login"
    else
      @render "wallpapers",
        data: -> {
          wallpapers: Wallpapers.find {},
            sort:
              createdAt: -1
        }
}


Router.route '/games', {
  name: 'games'
}

Router.route '/newWallpaper', {
  name: 'newWallpaper'
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