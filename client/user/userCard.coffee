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
	viewIcon: ->
		if Session.get('lookingAtWallpaper')
			"png/eye-off.png"
		else
			"png/eye.png"
	finishedEditing: ->
		if @published
			false
		else
			if @title == 'title' or @text == 'text' or @name == 'new-wallpaper' or @link == 'link' or @file == ''
				false
			else
				true

Template.userCard.events
	'click #logout': (e, t) ->
		Meteor.logout()
	'click #newsletter': (e) ->
		setModifier = { $set: {} }
		setModifier.$set['profile.newsletter' ] = !Meteor.user().profile.newsletter
		Meteor.users.update _id:Meteor.userId(), setModifier
	'click #publish' : (e, t) ->
		Wallpapers.update t.data._id,
			$set:
				published: true
	'click #add' : (e, t) ->
		Wallpapers.insert {}
		Router.go '/new-wallpaper'
	'click #cancel' : (e, t) ->
		Wallpapers.remove t.data._id
		Router.go '/'
	'mouseover #view' : (e) ->
		Session.set('lookingAtWallpaper', true)
		$('.smallCard').hide()
	'mouseout #view' : (e) ->
		Session.set('lookingAtWallpaper', false)
		$('.smallCard').show()