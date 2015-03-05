# FS.debug = true

mackbookProRetina = new FS.Store.GridFS("mackbookProRetina",
  mongoUrl: "mongodb://127.0.0.1:3001/meteor" # optional, defaults to Meteor's local MongoDB
	# mongoUrl: 'mongodb://localhost:27017/onlined' // to deploy to EC2
	# mongoOptions: {...},  // optional, see note below
	# transformWrite: myTransformWriteFunction, //optional
	# transformRead: myTransformReadFunction, //optional
	# maxTries: 1, // optional, default 5
	# chunkSize: 1024*1024  // optional, default GridFS chunk size in bytes (can be overridden per file).
	# Default: 2MB. Reasonable range: 512KB - 4MB
)

 # var anyStore = new FS.Store.S3("any", {
 #   accessKeyId: Meteor.settings.accessKeyId, //required
 #   secretAccessKey: Meteor.settings.secretAccessKey, //required
 #   bucket: Meteor.settings.anyStoreBucket //required
 # });


mackbookProRetinaSmall = new (FS.Store.GridFS)('mackbookProRetinaSmall',
  beforeWrite: (fileObj) ->
    {
      extension: 'png'
      type: 'image/png'
    }
  transformWrite: (fileObj, readStream, writeStream) ->
    gm(readStream).resize(2560,1600).stream('PNG').pipe writeStream
    return
)

iMacSmall = new (FS.Store.GridFS)('iMacSmall',
  beforeWrite: (fileObj) ->
    {
      extension: 'png'
      type: 'image/png'
    }
  transformWrite: (fileObj, readStream, writeStream) ->
    gm(readStream).resize(1920,1080).stream('PNG').pipe writeStream
    return
)

thumbnails = new (FS.Store.GridFS)('thumbnails',
  beforeWrite: (fileObj) ->
    {
      extension: 'png'
      type: 'image/png'
    }
  transformWrite: (fileObj, readStream, writeStream) ->
    gm(readStream).resize(300,168).stream('PNG').pipe writeStream
    return
)

# to make Images global in coffeeScript use this.
this.Images = new FS.Collection("images",
	stores: [mackbookProRetina, mackbookProRetinaSmall, iMacSmall, thumbnails]
	filter:
		allow:{
			contentTypes: ['image/*']
		},
		onInvalid: (message) ->
			console.log message
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