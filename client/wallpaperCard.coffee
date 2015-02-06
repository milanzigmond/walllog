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
  #   else
  #     console.log err
  # setModifier = {$set: {}}
  # setModifier.$set['file'] = fileObj._2id
  # Wallpapers.update {id: @_id}, setModifier 

Template.wallpaperCard.helpers
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
	likesCount: ->
		Likes.find(
			wallpaperId:@_id
		).count()
	commentsCount: ->
		Comments.find(
			wallpaperId:@_id
		).count()
	wallpaperSrc: ->
		wallpaper = Images.findOne @file
		wallpaper.url()

removeWallpaper = (id) ->
	console.log 'remove' + id
	Wallpapers.remove id


Template.wallpaperCard.events
	'click #delete': (e) -> 
		document.getElementById('deleteWallpaper').toggle();
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
		iHaveCommented =	Comments.findOne {
			wallpaperId: @_idin
			userId: Meteor.userId()
		}
		if iHaveCommented
			#do something
		else
			Comments.insert {	
				wallpaperId: @_id
				comment: "this is great"
			}
	'dragover': (e) ->
		preventActionsForEvent e
	'drop img': (e) ->
		preventActionsForEvent e
		console.log 'dropped'
		updateWallpaper e