# Users
Meteor.publish 'allUsers', ->
  Meteor.users.find()

Meteor.publish null, () ->
  Meteor.roles.find {}

Meteor.publish 'allWallpapers', () ->
  Wallpapers.find {}

Meteor.publish 'wallpaper', (wallpaperName) ->
  wallpaper = Wallpapers.find({name: wallpaperName}).fetch()[0]
  Counts.publish this, 'likes', Likes.find {wallpaperId:wallpaper._id}, noReady: true
  Wallpapers.find {name: wallpaperName}

Meteor.publish 'latestWallpaperId', () ->
  Wallpapers.find {},
    sort: createdAt: -1
    fields: name: 1
    limit: 1

Meteor.publish 'latestPublishedWallpaperId', () ->
  Wallpapers.find { published:true },
    sort: createdAt: -1
    fields: name: 1
    limit: 1

Meteor.publish 'allImages', () ->
  Images.find {}

Meteor.publish 'image', (wallpaperName) ->
  Images.find {'metadata.name':wallpaperName}

Meteor.publish 'allLikes', () ->
  Likes.find {}

Meteor.publish 'myLikes', () ->
  Likes.find {userId:@userId},
    fields: wallpaperId: 1

Meteor.publish 'allComments', () ->
  Comments.find {}

Meteor.publish 'comments', (wallpaperName) ->
  wallpaper = Wallpapers.findOne {name: wallpaperName}
  Comments.find {wallpaperId: wallpaper._id} if wallpaper

Meteor.publish 'userData', ->
  if @userId
    return Meteor.users.find({ _id: @userId }, fields:
      'newsletter': 1)
  else
    @ready()
  return