Template.registerHelper 'formatDate', (datetime) ->
	if moment
		moment(datetime).fromNow()
	else
    datetime

Template.registerHelper 'imageUrl', (fileId) ->
	image = Images.findOne fileId
	if image
		image.url()

Template.registerHelper 'thumbnailUrl', (fileId) ->
	image = Images.findOne fileId
	if image
		image.url
			store: 'thumbnails'

Template.registerHelper 'downloadFile', (fileId) ->
	file = Images.findOne fileId
	if file
		file.url({store:'iMac27'})+"&download=true"