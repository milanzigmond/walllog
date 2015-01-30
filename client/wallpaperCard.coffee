Template.wallpaperCard.helpers
	# iconset: (icon) ->
		# debugger
		# document.getEementBytId("iconset").applyIcon 'comment-outline'
	wallpaperSrc: ->
		wallpaper = Images.findOne @file
		wallpaper.url()

removeWallpaper = (id) ->
	console.log 'remove' + id
	Wallpapers.remove id

Template.wallpaperCard.events
	'click core-icon-button': (e) ->
		document.getElementById('deleteWallpaper').toggle();
	'click #yes': (e) ->
		console.log @_id 
		setTimeout (=>
		  removeWallpaper(@_id)
		), 250