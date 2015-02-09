Router.configure
  layoutTemplate: 'layout'
 
Router.route '/', {
  name: 'main'
  layoutTemplate: 'layout'
}

Router.route '/admin', {
  name: 'admin'
  layoutTemplate: 'layout'
  waitOn: ->
    NProgress.start()
    [
      Meteor.subscribe 'allWallpapers'
      Meteor.subscribe 'allImages'
      Meteor.subscribe 'allLikes'
      Meteor.subscribe 'allComments'
    ]
  data: ->
    {
      images: Images.find {}
      likes: Likes.find {}
      comments: Comments.find {}
      wallpapers: Wallpapers.find {},
            sort:
              createdAt: -1
    }
  action: ->
    NProgress.done()
    unless Meteor.user()
      @render "login"
    else
      @render "wallpapers"
}


Router.route '/games', {
  name: 'games'
}

Router.route '/likes', {
  name: 'likes'
  waitOn: ->
    NProgress.start()
    [
      Meteor.subscribe 'allWallpapers'
      Meteor.subscribe 'allImages'
      Meteor.subscribe 'allLikes'
    ]
  data: ->
    {
      images: Images.find {}
      likes: Likes.find {}
      wallpapers: Wallpapers.find {},
            sort:
              createdAt: -1

    }
  action: ->
    NProgress.done()
    @render "likes",
      data: -> {
        wallpapers : ->
          likes = Likes.find({
            userId: Meteor.userId()
          }).fetch()
          wallpaperIds = _.map likes, (like) -> like.wallpaperId
          Wallpapers.find {
              _id: {
                $in: wallpaperIds
                }
            },
            sort:
              createdAt: -1
      }
}

Router.route '/walllog', {
  name: 'walllog'
  layoutTemplate: 'walllog'
  template: 'teams'
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