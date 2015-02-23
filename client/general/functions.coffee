Template.registerHelper 'formatDate', (datetime) ->
	if moment
		moment(datetime).fromNow()
	else
    datetime

Template.registerHelper 'imageUrl', (fileId) ->
	if !fileId
		return
	image = Images.findOne {_id:fileId}
	image.url()

Template.registerHelper 'downloadFile', (fileId) ->
	# if !fileId
	# 	return
	# file = Images.findOne fileId
	# file.url()+"&download=true"


this.preventActionsForEvent = (event) ->
  event.preventDefault()
  event.stopPropagation()
  console.log "preventActionsForEvent, "+event.target