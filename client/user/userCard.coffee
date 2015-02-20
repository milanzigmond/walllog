Template.userCard.helpers
	username: ->
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
		if user.profile.newsletter
			"png/emailNewsletterOff.png"
		else
			"png/emailNewsletterOn.png"

Template.userCard.events
	'click #logout': (e) ->
		Meteor.logout()
	'click #newsletter': (e) ->
		console.log 'clicked'
		debugger
		# Meteor.user().profile.newsletter = !Meteor.user().profile.newsletter