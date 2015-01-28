Template.wallpapers.events
	'click paper-fab.addWallpaper': (e) ->
			Router.go 'newWallpaper'
			# document.getElementById('new').toggle();