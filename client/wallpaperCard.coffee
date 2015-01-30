Template.wallpaperCard.helpers
	likeIcon: ->
		if Likes.findOne {wallpaperId:@_id} 
			"png/heart.png" 
		else 
			"png/heart-outline.png"
	commentIcon: ->
		if Comments.findOne {wallpaperId:@_id} 
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
		setTimeout (=>
		  removeWallpaper(@_id)
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
			wallpaperId: @_id
			userId: Meteor.userId()
		}
		if iHaveCommented
			#do something
		else
			Comments.insert {	
				wallpaperId: @_id
				comment: "this is great"
			}	