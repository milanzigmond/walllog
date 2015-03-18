# FS.debug = true

originalWidth = 2880
originalHeight = 1800

this.stores = [
  {
    'name':'macbookProRetina'
    'width':originalWidth
    'height':originalHeight
  }
  {
    'name':'macbookProRetinaSmall'
    'width':2560
    'height':1600
  }
  {
    'name':'iMac27'
    'width':2560
    'height':1440
  }
  {
    'name':'iMacSmall'
    'width':1920
    'height':1080
  }
  {
    'name':'thumbnails'
    'width':300
    'height':187
  }
]

storesArray = []
_.each stores, (data) ->
  store = new FS.Store.GridFS(data.name,
    mongoUrl: "mongodb://127.0.0.1:3001/meteor"
    beforeWrite: (fileObj) ->
      {
        extension: 'png'
        type: 'image/png'
      }
    transformWrite: (fileObj, readStream, writeStream) ->
      originalAspectRatio = originalWidth/originalHeight
      storeAspectRatio = data.width/data.height
      if originalAspectRatio != storeAspectRatio
        # use crop
        offsetX = (originalWidth-data.width)/2
        offsetY = (originalHeight-data.height)/2
        gm(readStream).crop(data.width, data.height, offsetX, offsetY).stream('PNG').pipe writeStream
      else
        # use resize
        gm(readStream).resize(data.width,data.height).stream('PNG').pipe writeStream
  )
  storesArray.push(store)

# console.log storesArray


# macbookProRetina = new FS.Store.GridFS("macbookProRetina",
#   mongoUrl: "mongodb://127.0.0.1:3001/meteor" # optional, defaults to Meteor's local MongoDB
# 	mongoUrl: 'mongodb://localhost:27017/onlined' // to deploy to EC2
# 	mongoOptions: {...},  // optional, see note below
# 	transformWrite: myTransformWriteFunction, //optional
# 	transformRead: myTransformReadFunction, //optional
# 	maxTries: 1, // optional, default 5
# 	chunkSize: 1024*1024  // optional, default GridFS chunk size in bytes (can be overridden per file).
# 	Default: 2MB. Reasonable range: 512KB - 4MB
# )

 # var anyStore = new FS.Store.S3("any", {
 #   accessKeyId: Meteor.settings.accessKeyId, //required
 #   secretAccessKey: Meteor.settings.secretAccessKey, //required
 #   bucket: Meteor.settings.anyStoreBucket //required
 # });

# console.log macbookProRetina

# macbookProRetinaSmall = new (FS.Store.GridFS)('macbookProRetinaSmall',
#   beforeWrite: (fileObj) ->
#     {
#       extension: 'png'
#       type: 'image/png'
#     }
#   transformWrite: (fileObj, readStream, writeStream) ->
#     gm(readStream).resize(2560,1600).stream('PNG').pipe writeStream
#     return
# )

# iMac27 = new (FS.Store.GridFS)('iMac27',
#   beforeWrite: (fileObj) ->
#     {
#       extension: 'png'
#       type: 'image/png'
#     }
#   transformWrite: (fileObj, readStream, writeStream) ->
#     width = 2560
#     height = 1440
#     x = (2880 - width)/2
#     y = (1800 - height)/2
#     gm(readStream).crop(width, height, x, y).stream('PNG').pipe writeStream
#     return
# )

# iMacSmall = new (FS.Store.GridFS)('iMacSmall',
#   beforeWrite: (fileObj) ->
#     {
#       extension: 'png'
#       type: 'image/png'
#     }
#   transformWrite: (fileObj, readStream, writeStream) ->
#     width = 1920
#     height = 1080
#     x = (2880 - width)/2
#     y = (1800 - height)/2
#     gm(readStream).crop(width, height, x, y).stream('PNG').pipe writeStream
#     return
# )

# thumbnails = new (FS.Store.GridFS)('thumbnails',
#   beforeWrite: (fileObj) ->
#     {
#       extension: 'png'
#       type: 'image/png'
#     }
#   transformWrite: (fileObj, readStream, writeStream) ->
#     gm(readStream).resize(300,187).stream('PNG').pipe writeStream
#     return
# )

# to make Images global in coffeeScript use this.
this.Images = new FS.Collection("images",
  # stores: [macbookProRetina]
	stores: storesArray
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