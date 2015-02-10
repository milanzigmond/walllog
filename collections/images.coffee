# FS.debug = true

imageGridFSStore = new FS.Store.GridFS("images",
  mongoUrl: "mongodb://127.0.0.1:3001/meteor" # optional, defaults to Meteor's local MongoDB
	# mongoUrl: 'mongodb://localhost:27017/onlined' // to deploy to EC2
	# mongoOptions: {...},  // optional, see note below
	# transformWrite: myTransformWriteFunction, //optional
	# transformRead: myTransformReadFunction, //optional
	# maxTries: 1, // optional, default 5
	# chunkSize: 1024*1024  // optional, default GridFS chunk size in bytes (can be overridden per file).
	# Default: 2MB. Reasonable range: 512KB - 4MB
)

# to make Images global in coffeeScript use this.
this.Images = new FS.Collection("images",
	stores: [imageGridFSStore]
	filter:
		allow:
			extensions: [
				'png'
				'jpg'
				'jpeg'
				'gif'
				'bmp'
			]
)

Images.allow {
	insert: (userId, doc) ->
		Roles.userIsInRole userId, ['admin']
	update: (userId, doc, fields, modifier) ->
		Roles.userIsInRole userId, ['admin']
	remove: (userId, doc) ->
		Roles.userIsInRole userId, ['admin']
	download: (userId, doc) ->
		return true
}