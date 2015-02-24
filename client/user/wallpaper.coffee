updateWallpaper = (event, data) ->
	console.log 'update wallpaper: ' + data.name

	file = event.originalEvent.dataTransfer.files[0]
	fsFile = new FS.File(file)
	fsFile.userId = Meteor.userId()
	fsFile.metadata = name: data.name
	# fsFile.name = data.name
	fileObj = Images.insert fsFile, (err, fileObj) ->
		console.log err if err

	if data.file
		Images.remove data.file

	setModifier = {$set: {}}
	setModifier.$set['file'] = fileObj._id
	Wallpapers.update {_id: data._id}, setModifier
	return


Template.wallpaper.rendered = () ->
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
	# 	preventActionsForEvent e
	# 'drop': (e) ->
	# 	preventActionsForEvent e
	'dragover #dropzone': (e) ->
		preventActionsForEvent e
	'drop #dropzone': (e,t) ->
		preventActionsForEvent e
		updateWallpaper e, t.data
	'click #comment': (e) ->
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