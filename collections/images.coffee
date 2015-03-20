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
    'name':'thumbnail'
    'width':304
    'height':190
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