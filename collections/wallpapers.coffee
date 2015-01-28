this.Wallpapers = new Mongo.Collection("wallpapers")

Wallpapers.before.insert (userId, doc) ->
  doc.createdAt = new Date()
  doc.userId = userId

Wallpapers.before.remove (userId, doc) ->
	console.log doc.file
	Images.remove doc.file._id if doc.file