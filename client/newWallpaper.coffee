preventActionsForEvent = (event) ->
  event.preventDefault()
  event.stopPropagation()
  console.log "preventActionsForEvent"

saveWallpaper = (event) ->
  file = event.originalEvent.dataTransfer.files[0]
  fsFile = new FS.File(file)
  fileObj = Images.insert(fsFile, (err, fileObj) ->
    console.log err unless err
  )

  Wallpapers.insert file: fileObj

  setTimeout (->
	  Router.go 'admin'
	  return
	), 1000



Template.newWallpaper.events
	'dragover': (e) ->
		preventActionsForEvent e
	'drop': (e) ->
		preventActionsForEvent e
		console.log 'dropped'
		saveWallpaper e
	'click core-icon-button': (e) ->
		Router.go 'admin'