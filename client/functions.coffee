Template.registerHelper 'formatDate', (datetime) ->
	if moment
		moment(datetime).fromNow()
	else
    datetime

Template.registerHelper 'imageUrl', (fileId) ->
	image = Images.findOne fileId
	image.url()