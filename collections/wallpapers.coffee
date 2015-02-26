this.Wallpapers = new Mongo.Collection("wallpapers")

Wallpapers.before.insert (userId, doc) ->
  doc.createdAt = new Date()
  if !doc.userId
  	doc.userId = userId
  doc.title = "title"
  doc.text = "body"
  doc.link = "link"
  doc.name = "new-wallpaper"
  doc.file = ""
  doc.published = false
  return

# Wallpapers.before.update (userId, doc, fieldNames, modifier, options) ->
# 	if "name" in fieldNames and doc.file?
# 		debugger
# 		Images.update { _id: doc.file }, $set: name: modifier.$set.name

Wallpapers.before.remove (userId, doc) ->
	Meteor.call 'removeLikes', doc._id, (err) ->
	  if err
	    console.log err
	Meteor.call 'removeComments', doc._id, (err) ->
	  if err
	    console.log err
	Images.remove {
		_id: doc.file
	}

Wallpapers.allow {
	insert: (userId, doc) ->
		Roles.userIsInRole userId, ['admin']
	update: (userId, doc, fields, modifier) ->
		Roles.userIsInRole userId, ['admin']
	remove: (userId, doc) ->
		Roles.userIsInRole userId, ['admin']
}

Wallpapers.helpers {
	count: ->
		return 0
	likes: ->
		Likes.find(wallpaperId:@_id).count()
}

Meteor.methods {
	removeLikes: (wallId) ->
		Likes.remove {
			wallpaperId: wallId
		}
	removeComments: (wallId) ->
		Comments.remove {
			wallpaperId: wallId
		}
}