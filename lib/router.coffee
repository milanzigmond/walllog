Router.route '/:wallpaper', {
  name: 'wallpaper'
  layoutTemplate: 'publicLayout'
  waitOn: ->
    NProgress.start()
    [
      Meteor.subscribe 'wallpaper', @params.wallpaper
      Meteor.subscribe 'image', @params.wallpaper
      Meteor.subscribe 'comments', @params.wallpaper
      Meteor.subscribe 'myLikes'
      Meteor.subscribe 'userData'
    ]
  data: ->
    wallpaper = Wallpapers.findOne
      name: @params.wallpaper
    if !wallpaper
      NProgress.done()
      Router.go '/'
    wallpaper
  action: ->
    NProgress.done()
    @render 'wallpaper'
}


Router.route '/', {
  name: 'setup'
  layoutTemplate: 'publicLayout'
  waitOn: ->
    if Roles.userIsInRole Meteor.userId(), ['admin']
      Meteor.subscribe 'latestWallpaperId'
    else if !Roles.userIsInRole Meteor.userId(), ['admin']
      # user is either 'regular' or not signed in at all (guest)
      Meteor.subscribe 'latestPublishedWallpaperId'
  data: ->
    if !this.ready()
      return
    
    latestWallpaper = Wallpapers.findOne()
          
    if latestWallpaper?.name
      Router.go '/'+latestWallpaper.name
}