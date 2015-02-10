this.Wallpapers = new Mongo.Collection("wallpapers")

Wallpapers.before.insert (userId, doc) ->
  doc.createdAt = new Date()
  doc.userId = userId
  doc.title = "Title"
  doc.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum molestiae suscipit odio corrupti delectus est, quam repellat, vitae minus distinctio, eius quae voluptate beatae doloribus!"
  doc.link = "link.com"

Wallpapers.before.remove (userId, doc) ->
	Images.remove {
		_id: doc.file
	}
	Meteor.call 'removeLikes', doc._id, (err) ->
	  if err
	    console.log err
	Meteor.call 'removeComments', doc._id, (err) ->
	  if err
	    console.log err

Wallpapers.allow {
	insert: (userId, doc) ->
		doc.userId is userId
	update: (userId, doc, fields, modifier) ->
		doc.userId is userId
	remove: (userId, doc) ->
		doc.userId is userId
}

Wallpapers.helpers {
	count: ->
		return 0
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
