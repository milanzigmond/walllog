this.Comments = new Mongo.Collection "comments"

Comments.before.insert (userId, doc) ->
  doc.createdAt = new Date()
  doc.userId = userId
  user = Meteor.users.findOne {
  	_id:userId
  }
  doc.name = user.username


Comments.allow {
	insert: (userId, doc) ->
		doc.userId is userId
	update: (userId, doc, fields, modifier) ->
		doc.userId is userId
	remove: (userId, doc) ->
		doc.userId is userId
}