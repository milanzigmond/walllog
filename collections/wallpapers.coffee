this.Wallpapers = new Mongo.Collection("wallpapers")

Wallpapers.before.insert (userId, doc) ->
  if !doc.userId
  	doc.userId = userId
  doc.createdAt = new Date()
  doc.file = ""
  doc.title = "title"
  doc.text = "text"
  doc.name = "new-wallpaper"
  doc.preview = "Minutes preview of video link"
  doc.video = "Full video link for subscribers"
  doc.source = "fileId here"
  doc.published = false
  return

Wallpapers.before.update (userId, doc, fieldNames, modifier, options) ->
	return if doc.published
	# if any of the default values are present
	titleOk = textOk = nameOk = linkOk = fileOk = false

	if 'title' in fieldNames
		if modifier.$set.title != 'title'
			titleOk = true
	else
		if doc.title != 'title'
			titleOk = true

	if 'text' in fieldNames
		if modifier.$set.text != 'text'
			textOk = true
	else
		if doc.text != 'text'
			textOk = true

	if 'name' in fieldNames
		if modifier.$set.name != 'new-wallpaper'
			nameOk = true
	else
		if doc.name != 'new-wallpaper'
			nameOk = true

	if 'file' in fieldNames
		if modifier.$set.file != ''
			fileOk = true
	else
		if doc.file != ''
			fileOk = true

	if titleOk and textOk and nameOk and linkOk and fileOk
		modifier.$set.published = true

Wallpapers.after.update (userId, doc, fieldNames, modifier, options) ->
	if "name" in fieldNames and doc.file?
		Images.update { _id: doc.file }, $set: 'metadata.name': modifier.$set.name
		Router.go '/'+modifier.$set.name

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