Template.registerHelper 'formatDate', (datetime) ->
	if moment
		moment(datetime).fromNow()
	else
    datetime

Template.registerHelper 'imageUrl', (fileId) ->
	return if !fileId
	image = Images.findOne fileId
	image.url()

Template.registerHelper 'downloadFile', (fileId) ->
	return if !fileId
	file =Images.findOne fileId
	file.url()+"&download=true"


this.preventActionsForEvent = (event) ->
  event.preventDefault()
  event.stopPropagation()
  console.log "preventActionsForEvent"