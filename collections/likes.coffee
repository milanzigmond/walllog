this.Likes = new Mongo.Collection("likes")

Likes.before.insert (userId, doc) ->
  doc.createdAt = new Date()
  doc.userId = userId

Likes.allow {
	insert: (userId, doc) ->
		yes
	update: (userId, doc, fields, modifier) ->
		Roles.userIsInRole userId, ['admin']
	remove: (userId, doc) ->
		yes
}