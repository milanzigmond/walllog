# Users
Meteor.publish 'allUsers', ->
  console.log 'allUsersPublication'
  Meteor.users.find()

Meteor.publish 'allWallpapers', () ->
  console.log 'allWallpapersPublication'
  Wallpapers.find {}

Meteor.publish 'wallpaper', (name) ->
  console.log 'wallpaperPublication'
  Wallpapers.find {name: name}

Meteor.publish 'allImages', () ->
  console.log 'allImagesPublication'
  Images.find {}

Meteor.publish 'images', (wallpaperName) ->
  console.log 'imagesPublication'
  wallpaper = Wallpapers.findOne {name: wallpaperName}
  Images.find {_id:wallpaper.file}

Meteor.publish 'allLikes', () ->
  console.log 'allLikesPublication'
  Likes.find {}

Meteor.publish 'myLikes', () ->
  console.log 'myLikesPublication'
  Likes.find {userId:@userId}

Meteor.publish 'wallpaperLikes', (wallpaperName) ->
  console.log 'wallpaperLikesPub, wallpaperName:'+wallpaperName
  wallpaper = Wallpapers.findOne {name: wallpaperName}
  Likes.find {wallpaperId:wallpaper._id}

Meteor.publish 'allComments', () ->
  console.log 'allCommentsPublication'
  Comments.find {}

Meteor.publish 'comments', (wallpaperName) ->
  console.log 'allCommentsPublication'
  wallpaper = Wallpapers.findOne {name: wallpaperName}
  Comments.find {wallpaperId: wallpaper._id}

# Meteor.publish 'userData', ->
#   if @userId
#     return Meteor.users.find({ _id: @userId }, fields:
#       'newsletter': 1)
#   else
#     @ready()
#   return