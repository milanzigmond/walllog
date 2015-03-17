Router.route '/:wallpaper', {
  name: 'wallpaper'
  layoutTemplate: 'publicLayout'
  # loadingTemplate: 'loading'
  waitOn: ->
    # NProgress.start()
    [
      Meteor.subscribe 'wallpaper', @params.wallpaper
      Meteor.subscribe 'image', @params.wallpaper
      Meteor.subscribe 'comments', @params.wallpaper
      Meteor.subscribe 'myLikes', @params.wallpaper
      Meteor.subscribe 'userData'
    ]
  action: ->
    @render 'wallpaper',
      data: ->
        Wallpapers.findOne
          name: @params.wallpaper
    # console.log 'wallpaper action, ready: '+@ready()
    # if @ready()
    #   # NProgress.done()
    #   # debugger
    #   console.log 'rendering wallpaper'
    #   @render 'wallpaper'
    # else
    #   console.log 'wallpaper loading'
      # @render 'loading'
    # wallpaper = Wallpapers.findOne
    #   name: @params.wallpaper
    # if !wallpaper
    #   Router.go '/'
    # @render 'wallpaper'
}


Router.route '/', {
  name: 'setup'
  layoutTemplate: 'publicLayout'
  loadingTemplate: 'loading'
  waitOn: ->
    if Roles.userIsInRole Meteor.userId(), ['admin']
      Meteor.subscribe 'latestWallpaperId'
    else if !Roles.userIsInRole Meteor.userId(), ['admin']
      # user is either 'regular' or not signed in at all (guest)
      Meteor.subscribe 'latestPublishedWallpaperId'
  action: ->
    if @ready()
      console.log 'main ready'
      latestWallpaper = Wallpapers.findOne()
      if latestWallpaper?.name
        Router.go '/'+latestWallpaper.name
      else
        @render 'setup'
}