Template.userCard.helpers
	likesCount: ->
		Likes.find(
			userId:Meteor.userId()
		).count()
	likeIcon: ->
		if Likes.findOne {
			userId:Meteor.userId()
			}
			"png/ic_favorite_white_24dp.png"
		else
			"png/ic_favorite_outline_white_24dp.png"