# Router.configure
#   layoutTemplate: 'layout'

# Router.route '/admin', {
#   name: 'admin'
#   layoutTemplate: 'layout'
#   waitOn: ->
#     NProgress.start()
#     [
#       Meteor.subscribe 'allWallpapers'
#       Meteor.subscribe 'allImages'
#       Meteor.subscribe 'allLikes'
#       Meteor.subscribe 'allComments'
#     ]
#   data: ->
#     {
#       images: Images.find {}
#       likes: Likes.find {}
#       comments: Comments.find {}
#       wallpapers: Wallpapers.find {},
#         sort:
#           createdAt: -1
#     }
#   action: ->
#     NProgress.done()
#     unless Meteor.user()
#       @render "login"
#     else
#       @render "wallpapers"
# }

# Router.route '/likes', {
#   name: 'likes'
#   layoutTemplate: 'layout'
#   waitOn: ->
#     NProgress.start()
#     [
#       Meteor.subscribe 'allWallpapers'
#       Meteor.subscribe 'allImages'
#       Meteor.subscribe 'allLikes'
#     ]
#   data: ->
#     {
#       images: Images.find {}
#       likes: Likes.find {}
#       wallpapers: Wallpapers.find {},
#             sort:
#               createdAt: -1

#     }
#   action: ->
#     NProgress.done()
#     @render "likes",
#       data: -> {
#         wallpapers : ->
#           likes = Likes.find({
#             userId: Meteor.userId()
#           }).fetch()
#           wallpaperIds = _.map likes, (like) -> like.wallpaperId
#           Wallpapers.find {
#               _id: {
#                 $in: wallpaperIds
#                 }
#             },
#             sort:
#               createdAt: -1
#       }
# }

# Router.route '/walllog', {
#   name: 'walllog'
#   layoutTemplate: 'walllog'
#   template: 'teams'
# }

# Router.route '/newWallpaper', {
#   name: 'newWallpaper'
# }

 
# requireLogin = ->
#   if !Meteor.user()
#     if Meteor.loggingIn()
#       # We could render a loading template here
#     else
#       @render('accessDenied')
#   	  @next()
#   else
#     @next()
 
# # Router.onBeforeAction(requireLogin)

Router.route '/:wallpaper', {
  name: 'wallpaper'
  layoutTemplate: 'publicLayout'
  waitOn: ->
    console.log 'waiton wallpaper'
    NProgress.start()
    [
      Meteor.subscribe 'wallpaper', @params.wallpaper
      Meteor.subscribe 'image', @params.wallpaper
      Meteor.subscribe 'comments', @params.wallpaper
      Meteor.subscribe 'wallpaperLikes', @params.wallpaper
      Meteor.subscribe 'myLikes'
      Meteor.subscribe 'stream'
      Meteor.subscribe 'userData'
    ]
  data: ->
    Wallpapers.findOne
      name: @params.wallpaper
  action: ->
    NProgress.done()
    @render 'wallpaper'
}


Router.route '/', {
  name: 'setup'
  layoutTemplate: 'publicLayout'
  waitOn: ->
    console.log 'wait on / '+Meteor.userId()
    Meteor.subscribe 'latestPublishedWallpaperId'
  data: ->
    console.log 'data'
    if Wallpapers.find().count() > 0
      latestWallpaperId = Wallpapers.findOne()
      Router.go '/'+latestWallpaperId.name
}


