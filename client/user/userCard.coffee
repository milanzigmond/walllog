Template.userCard.rendered = () ->
	if Router.current().params.wallpaper == "new-wallpaper"
		Session.set 'editingWallpaper', @data?._id

Template.userCard.helpers
	username: ->
		return if !Meteor.user()
		Meteor.user().username
	likesCount: ->
		Likes.find(
			userId:Meteor.userId()
		).count()
	addIcon: ->
		if Session.get 'editingWallpaper'
			"clear"
		else
			"add"
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
		false if @title == 'title' or @text == 'text' or @name == 'new-wallpaper' or @link == 'link' or @file == ''


Template.userCard.events
	'click #logout': (e) ->
		Meteor.logout()
	'click #newsletter': (e) ->
		setModifier = { $set: {} }
		setModifier.$set['profile.newsletter' ] = !Meteor.user().profile.newsletter
		Meteor.users.update _id:Meteor.userId(), setModifier
	'click #add' : (e) ->
		if Session.get 'editingWallpaper'
			Wallpapers.remove Session.get 'editingWallpaper'
			Router.go '/'
		else
			Wallpapers.insert {}
			Router.go '/new-wallpaper'
	'mouseover #view' : (e) ->
		Session.set('lookingAtWallpaper', true)
		$('.smallCard').hide()
	'mouseout #view' : (e) ->
		Session.set('lookingAtWallpaper', false)
		$('.smallCard').show()