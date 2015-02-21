Template.userCard.helpers
	username: ->
		return if !Meteor.user()
		Meteor.user().username
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
	newsletterIcon: ->
		user = Meteor.user()
		if user and user.profile.newsletter
			"png/emailNewsletterOn.png"
		else
			"png/emailNewsletterOff.png"
	newsletterTooltip: ->
		user = Meteor.user()
		if user and user.profile.newsletter
			"Turn off email newsletter"
		else
			"Turn on email newsletter"

Template.userCard.events
	'click #logout': (e) ->
		Meteor.logout()
	'click #newsletter': (e) ->
		setModifier = { $set: {} }
		setModifier.$set['profile.newsletter' ] = !Meteor.user().profile.newsletter
		Meteor.users.update _id:Meteor.userId(), setModifier