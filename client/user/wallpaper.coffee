Tracker.autorun () ->
	if Session.get('fileId')
		Meteor.subscribe 'image', Session.get('fileId')

updateWallpaper = (event, wallpaperId, wallpaperFile) ->
	console.log 'update wallpaper'
	file = event.originalEvent.dataTransfer.files[0]
	fsFile = new FS.File(file)
	fsFile.userId = Meteor.userId()
	if wallpaperFile
		Images.remove wallpaperFile
		fileObj = Images.insert fsFile, (err, fileObj) ->
	    console.log err if err
	else
		fileObj = Images.insert fsFile, (err, fileObj) ->
	    console.log err if err

	setModifier = {$set: {}}
	setModifier.$set['file'] = fileObj._id
	Wallpapers.update {_id: wallpaperId}, setModifier
	Session.set 'fileId', fileObj._id
	return


Template.wallpaper.rendered = () ->
	wallpaper = Wallpapers.findOne()
	Session.set 'fileId', wallpaper.file

	stream = Wallpapers.find( {} , {
    fields: name: 1
    _id: 0
    }).fetch()
	@stream = _.map stream, (wallpaper) ->
		wallpaper.name
	console.log @stream


Template.wallpaper.helpers
	likesCount: ->
		Likes.find(
			wallpaperId:@_id
		).count()
	commentsCount: ->
		Comments.find(
			wallpaperId:@_id
		).count()
	comments: ->
		Comments.find {
			wallpaperId:@_id
			},sort:
				createdAt: -1
	likeIcon: ->
		if Meteor.user() and Likes.findOne {
			wallpaperId:@_id
			userId:Meteor.userId()
			}
			"png/ic_favorite_white_24dp.png"
		else
			"png/ic_favorite_outline_white_24dp.png"
	commentIcon: ->
		if Comments.findOne {
			wallpaperId:@_id
			userId:Meteor.userId()
			}
			"png/ic_comment_white_24dp.png"
		else
			"png/ic_comment_white_24dp.png"

Template.wallpaper.events
	# 'dragover': (e) ->
	# 	console.log 'wallpaper dragover'
	# 	preventActionsForEvent e
	# 'drop': (e) ->
	# 	console.log 'wallpaper drop'
	# 	preventActionsForEvent e
	'dragover #dropzone': (e) ->
		preventActionsForEvent e
	'drop #dropzone': (e) ->
		preventActionsForEvent e
		console.log 'dropped'
		updateWallpaper e, @_id, @file
	'click #comment': (e) ->
		console.log 'clicked'+$('.commentsWrapper')
		$('.commentsWrapper').slideToggle(400)
	'keyup #commentText' : (e) ->
		preventActionsForEvent e
		if e.keyCode is 27
    	console.log 'escape pressed'
		if e.keyCode is 13
			console.log 'enter pressed'
			Comments.insert {
    		wallpaperId: @_id
    		comment: e.target.value
				}
			e.target.value = ""
			e.target.parentElement.update()
			$(e.target).blur()
			if $('.commentsWrapper').css('display') is "none"
				$('.commentsWrapper').slideToggle(400)
	'click #like': (e) ->
		if !Meteor.user()
			return
		iLike =	Likes.findOne {
			wallpaperId: @_id
			userId: Meteor.userId()
		}
		if iLike
			Likes.remove { _id:iLike._id }
		else
			Likes.insert {
				wallpaperId: @_id
				wallpaperName: @name
			}
	'click .bgImage' : (e, t) ->
  	currentNameIndex = t.stream.indexOf @name
  	currentNameIndex++
  	console.log 'bgImage clicked: '+currentNameIndex+", "+t.stream.length
  	if currentNameIndex >= t.stream.length
  		currentNameIndex = 0
  	nextWallpaperName = t.stream[currentNameIndex]
  	Router.go '/'+nextWallpaperName