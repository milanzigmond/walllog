Template.userCard.helpers
	isNotEditing: ->
		# debugger
		wallpaper = Wallpapers.findOne()
		if !wallpaper
			# there is no wallpaper yet, show + button
			true
		else
			# just mirror published flag
			wallpaper.published
	likes: ->
		Likes.find {},
			sort: createdAt: -1
	username: ->
		return if !Meteor.user()
		Meteor.user().username
	likesCount: ->
		Likes.find().count()
	likeIcon: ->
		if Likes.find().count() > 0
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
			"Turn OFF email newsletter"
		else
			"Turn ON email newsletter"
	viewIcon: ->
		if Session.get('lookingAtWallpaper')
			"png/eye-off.png"
		else
			"png/eye.png"

Template.userCard.events
	'click #likeImage': (e, t) ->
		console.log 'like image clicked:'+@wallpaperName
		Router.go 'wallpaper',
			wallpaper: @wallpaperName
	'click #likes': (e,t) ->
		return unless Likes.find().count() > 0
		if Session.get('openSection') == 'likes'
			Session.set 'openSection', null
			t.find('#userCard').selected = "icons"
		else
			t.find('#userCard').selected = "likes"
			Session.set 'openSection', "likes"
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