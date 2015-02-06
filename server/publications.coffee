# Users
Meteor.publish 'allUsers', ->
  console.log 'allUsersPublication'
  Meteor.users.find()
Meteor.publish 'allWallpapers', () ->
  console.log 'allWallpapersPublication'
  Wallpapers.find {}
Meteor.publish 'allImages', () ->
  console.log 'allImagesPublication'
  Images.find {}
Meteor.publish 'allLikes', () ->
  console.log 'allLikesPublication'
  Likes.find {}
# Websites
# Meteor.publish 'sitenameSearch', (query) ->
#   check query, String
#   if _.isEmpty(query)
#     return @ready()
#   console.log 'query:' + query
#   Websites.search query
# Meteor.publish 'stream', (limit) ->
#   console.log 'streamPublication'
#   check limit, Number
#   cursors = []
#   largeImageSections = []
#   userIds = []
#   imageIds = []
#   websiteIds = []
#   largeImageSections = Sections.find({ name: 'largeImage' },
#     sort: createdAt: 1
#     limit: limit)
#   imageIds = largeImageSections.map((section) ->
#     section.data.image
#   )
#   websiteIds = largeImageSections.map((section) ->
#     section.websiteId
#   )
#   userIds = largeImageSections.map((section) ->
#     section.userId
#   )
#   # leave only uniques in arrays
#   imageIds = _.uniq(imageIds)
#   websiteIds = _.uniq(websiteIds)
#   userIds = _.uniq(userIds)
#   cursors.push largeImageSections
#   cursors.push Websites.find({ _id: $in: websiteIds },
#     fields:
#       sitename: 1
#       userId: 1
#       createdAt: 1
#     sort: createdAt: 1
#     limit: limit)
#   cursors.push Users.find({ _id: $in: userIds }, fields: username: 1)
#   cursors.push Images.find(_id: $in: imageIds)
#   cursors