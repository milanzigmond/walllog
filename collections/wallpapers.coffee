this.Wallpapers = new Mongo.Collection("wallpapers")

Wallpapers.before.insert (userId, doc) ->
  doc.createdAt = new Date()
  doc.userId = userId
  doc.title = "Title"
  doc.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Earum molestiae suscipit odio corrupti delectus est, quam repellat, vitae minus distinctio, eius quae voluptate beatae doloribus!"
  doc.link = "link.com"


Wallpapers.before.remove (userId, doc) ->
	console.log doc.file
	Images.remove doc.file._id if doc.file