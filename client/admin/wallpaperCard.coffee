preventActionsForEvent = (event) ->
  event.preventDefault()
  event.stopPropagation()
  console.log "preventActionsForEvent"

updatWallpaper = (event) ->
  file = event.originalEvent.dataTransfer.files[0]
  fsFile = new FS.File(file)
  # fileObj = Images.insert(fsFile, (err, fileObj) ->
  #   console.log err unless err
  # )

  # fileObj = Images.insert(fsFile, (err, fileObj) ->
  #   if not err
  #     Images.remove @wallpaperId if @wallpaperId?
  #   else  #     console.log err
  # setModifier = {$set: {}}
  # setModifier.$set['file'] = fileObj._2id
  # Wallpapers.update {id: @_id}, setModifier
Template.wallpaperCard.helpers
	comments: ->
		Comments.find {wallpaperId:@_id},
			sort:
				createdAt: -1
	likeIcon: ->
		if Likes.findOne {
			wallpaperId:@_id
			userId:Meteor.userId()
			}
			"png/heart.png"
		else
			"png/heart-outline.png"
	commentIcon: ->
		if Comments.findOne {
			wallpaperId:@_id
			userId:Meteor.userId()
			}
			"png/comment.png"
		else
			"png/comment-outline.png"
	myComment: ->
		if @userId is Meteor.userId()
			"myComment"
		else
			""
	likesCount: ->
		Likes.find(
			wallpaperId:@_id
		).count()
	commentsCount: ->
		Comments.find(
			wallpaperId:@_id
		).count()

removeWallpaper = (id) ->
	console.log 'remove' + id
	Wallpapers.remove {
		_id: id
	}


Template.wallpaperCard.events
	'click #delete': (e) ->
		_id = @_id
		setTimeout (->
		  removeWallpaper(_id)
		), 250
		# document.GETELEMENTBYID('deleteWallpaper').toggle();
	'click #yes': (e) ->
		_id = @_id
		setTimeout (->
		  removeWallpaper(_id)
		), 250
	'click #like': (e) ->
		iLike =	Likes.findOne {
			wallpaperId: @_id
			userId: Meteor.userId()
		}
		if iLike
			Likes.remove {
				_id:iLike._id
			}
		else
			Likes.insert {
				wallpaperId: @_id
			}
	'click #comment': (e) ->
		$('.commentsWrapper').slideToggle(400)
	'dragover': (e) ->
		preventActionsForEvent e
	'drop img': (e) ->
		preventActionsForEvent e
		console.log 'dropped'
		updateWallpaper e
	'keyup textarea' : (e) ->
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
