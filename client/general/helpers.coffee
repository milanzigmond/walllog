selectStoreBasedOnScreenResolution = () ->
	if window.devicePixelRatio != undefined
	  dpr = window.devicePixelRatio
	else
	  dpr = 1
	screenWidth = window.screen.width * dpr
	screenHeight = window.screen.height * dpr
	for store in stores
		if (store.width == screenWidth and store.height == screenHeight)
			return store.name

Template.registerHelper 'formatDate', (datetime) ->
	if moment
		moment(datetime).fromNow()
	else
    datetime

Template.registerHelper 'imageUrl', (fileId) ->
	image = Images.findOne fileId
	if image
		store = selectStoreBasedOnScreenResolution()
		if store
			console.log 'store: '+store
			image.url({store:store})
		else
			# "cannot find store"

Template.registerHelper 'thumbnailUrl', (fileId) ->
	image = Images.findOne fileId
	if image
		image.url
			store: 'thumbnail'

Template.registerHelper 'downloadFile', (fileId) ->
	file = Images.findOne fileId
	if file
		store = selectStoreBasedOnScreenResolution()
		file.url({store:store})+"&download=true"