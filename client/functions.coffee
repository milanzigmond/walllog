Template.registerHelper 'formatDate', (datetime) ->
	if moment
		moment(datetime).fromNow()
	else
    datetime