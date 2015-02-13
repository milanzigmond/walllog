Template.registerHelper 'formatDate', (datetime) ->
	if moment
		moment(datetime).fromNow()
	else
    datetime

Template.registerHelper 'imageUrl', (fileId) ->
	image = Images.findOne fileId
	image.url()


this.preventActionsForEvent = (event) ->
  event.preventDefault()
  event.stopPropagation()
  console.log "preventActionsForEvent"