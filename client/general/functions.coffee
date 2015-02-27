Template.registerHelper 'formatDate', (datetime) ->
	if moment
		moment(datetime).fromNow()
	else
    datetime

Template.registerHelper 'imageUrl', (fileId) ->
	# console.log 'imageUrl for fileId: '+fileId
	image = Images.findOne {_id:fileId}
	if image
		image.url()

Template.registerHelper 'downloadFile', (fileId) ->
	file = Images.findOne fileId
	if file
		file.url()+"&download=true"


this.preventActionsForEvent = (event) ->
  event.preventDefault()
  event.stopPropagation()
  # console.log "preventActionsForEvent, "+event.target