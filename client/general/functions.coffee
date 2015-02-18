Template.registerHelper 'formatDate', (datetime) ->
	if moment
		moment(datetime).fromNow()
	else
    datetime

Template.registerHelper 'imageUrl', (fileId) ->
	image = Images.findOne fileId
	image.url()

Template.registerHelper 'downloadFile', (fileId) ->
	file =Images.findOne fileId
	file.url()+"&download=true"


this.preventActionsForEvent = (event) ->
  event.preventDefault()
  event.stopPropagation()
  console.log "preventActionsForEvent"