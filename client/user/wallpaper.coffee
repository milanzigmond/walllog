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
		if Likes.findOne {
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