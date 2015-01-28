Template.wallpaperCard.helpers
	wallpaperSrc: ->
		@file.url()

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