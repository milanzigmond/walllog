# Users
Meteor.publish 'allUsers', ->
  console.log 'allUsersPublication'
  Meteor.users.find()

Meteor.publish null, () ->
  Meteor.roles.find {}

Meteor.publish 'allWallpapers', () ->
  console.log 'allWallpapersPublication'
  Wallpapers.find {}

Meteor.publish 'wallpaper', (name) ->
  console.log 'wallpaperPublication'
  Wallpapers.find {name: name}

Meteor.publish 'latestWallpaperId', () ->
  console.log 'latestWallpaperIdPublication'
  Wallpapers.find {},
    limit: 1
    sort: createdAt: -1
    fields: name: 1

Meteor.publish 'latestPublishedWallpaperId', () ->
  console.log 'latestPublishedWallpaperIdPublication'
  Wallpapers.find {published:true},
    limit: 1
    sort: createdAt: -1
    fields: name: 1

Meteor.publish 'allImages', () ->
  console.log 'allImagesPublication'
  Images.find {}

Meteor.publish 'image', (wallpaperName) ->
  console.log 'imagePublication: '+wallpaperName
  console.log  Images.find({name:wallpaperName}).count()
  Images.find {'metadata.name':wallpaperName}


Meteor.publish 'allLikes', () ->
  console.log 'allLikesPublication'
  Likes.find {}

Meteor.publish 'myLikes', () ->
  console.log 'myLikesPublication'
  Likes.find {userId:@userId}

Meteor.publish 'wallpaperLikes', (wallpaperName) ->
  console.log 'wallpaperLikesPub, wallpaperName:'+wallpaperName
  wallpaper = Wallpapers.find({name: wallpaperName})
  Likes.find {wallpaperId:wallpaper._id} if wallpaper

Meteor.publish 'allComments', () ->
  console.log 'allCommentsPublication'
  Comments.find {}

Meteor.publish 'comments', (wallpaperName) ->
  console.log 'allCommentsPublication'
  wallpaper = Wallpapers.findOne {name: wallpaperName}
  Comments.find {wallpaperId: wallpaper._id} if wallpaper

Meteor.publish 'stream', () ->
  console.log 'streamPublication'
  Wallpapers.find {},
    sort: createdAt: -1
    fields: name: 1
    limit: 10

Meteor.publish 'userData', ->
  console.log 'userDataPublication'
  if @userId
    return Meteor.users.find({ _id: @userId }, fields:
      'newsletter': 1)
  else
    @ready()
  return