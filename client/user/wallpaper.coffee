closeLikesSectionIfEmpty = (t) ->
	myLikesCount = Likes.find({userId:Meteor.userId()}).count()
	return unless myLikesCount == 0
	if Session.get('openSection') == 'likes'
		Session.set 'openSection', null
		document.getElementById('userCard').selected = "icons"

Template.wallpaper.rendered = () ->
	video = document.getElementById('video')
	# console.log 'rendered - video:'+video
	return unless video
	video.addEventListener 'ended', ->
		console.log 'video ended'
		Session.set('videoPlaying', false)
		$('#video').fadeOut()

	return unless @data

	# $('meta[property^="og:"]').remove()
	# url = location.origin + location.pathname
	# $('<meta>', { property: 'og:type', content: 'article' }).appendTo 'head'
	# $('<meta>', { property: 'og:site_name', content: location.hostname }).appendTo 'head'
	# $('<meta>', { property: 'og:url', content: url }).appendTo 'head'
	# $('<meta>', { property: 'og:title', content: @data.title }).appendTo 'head'
	# $('<meta>', { property: 'og:description', content: @data.text }).appendTo 'head'
	# $('<meta>', { property: 'og:image', content: location.origin + Images.findOne().url() }).appendTo 'head'
	window.fbAsyncInit = ->
	  FB.init
	    appId: '636830676449645'
	    xfbml: true
	    oauth: true
	    version: 'v2.1'

	((d, s, id) ->
	  js = undefined
	  fjs = d.getElementsByTagName(s)[0]
	  if d.getElementById(id)
	    return
	  js = d.createElement(s)
	  js.id = id
	  js.src = '//connect.facebook.net/en_US/sdk.js'
	  fjs.parentNode.insertBefore js, fjs
	  return
	) document, 'script', 'facebook-jssdk'

updateWallpaper = (event, data) ->
	console.log 'update wallpaper: ' + data.name

	file = event.originalEvent.dataTransfer.files[0]
	fsFile = new FS.File(file)
	fsFile.userId = Meteor.userId()
	fsFile.metadata = name: data.name
	# fsFile.name = data.name
	fileObj = Images.insert fsFile, (err, fileObj) ->
		console.log err if err

	if data.file
		Images.remove data.file

	setModifier = {$set: {}}
	setModifier.$set['file'] = fileObj._id
	Wallpapers.update {_id: data._id}, setModifier
	return

Template.wallpaper.helpers
	likesCount: ->
		Meteor.call 'countLikesForWallpaperId', @_id, (err, res) ->
			res
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
		if Meteor.user() and Likes.findOne {
			wallpaperId:@_id
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
	playIcon: ->
		if Session.get('videoPlaying')
			"png/ic_pause_white_24dp.png"
		else
			"png/ic_play_arrow_white_24dp.png"

Template.wallpaper.events
	# 'dragover': (e) ->
	# 	preventActionsForEvent e
	# 'drop': (e) ->
	# 	preventActionsForEvent e
	'click #share': (e) ->
		FB.ui {
		  method: 'share'
		  href: location.origin + location.pathname
		 #  method: 'feed'
			# name: @title
			# link: location.origin + location.pathname
			# picture: location.origin + Images.findOne().url({store:'thumbnail'})
			# caption: @text
			# description: @text
			# message: 'MESSAGE HERE'
		}, (response) ->
	'dragover #dropzone': (e) ->
		preventActionsForEvent e
	'drop #dropzone': (e,t) ->
		preventActionsForEvent e
		updateWallpaper e, t.data
	'click #comment': (e) ->
		$('#commentsWrapper').slideToggle(400)
	'click #remove': (e) ->
		Wallpapers.remove @_id
		Router.go "/"
	'click #playVideo': (e) ->
		playing = Session.get('videoPlaying')
		video = document.getElementById('video')
		if playing
			Session.set('videoPlaying', false)
			$('#video').fadeOut()
			video.pause()
		else
			Session.set("videoPlaying", true)
			$('#video').fadeIn()
			video.play()
	'keyup #commentText' : (e) ->
		preventActionsForEvent e
		if e.keyCode is 27
    	console.log 'escape pressed'
		if e.keyCode is 13
			console.log 'enter pressed'
			# temp fix to remove enter at the end entered text
			comment = e.target.value.substr(0,e.target.value.length-1)
			Comments.insert {
    		wallpaperId: @_id
    		comment: comment
				}
			e.target.value = ""
			e.target.parentElement.update()
			$(e.target).blur()
			if $('#commentsWrapper').css('display') is "none"
				$('#commentsWrapper').slideToggle(400)
	'click #like': (e) ->
		if !Meteor.user()
			return
		iLike =	Likes.findOne {
			wallpaperId: @_id
		}
		if iLike
			Likes.remove { _id:iLike._id }
			closeLikesSectionIfEmpty()
		else
			Likes.insert {
				wallpaperId: @_id
				wallpaperName: @name
				file: @file
			}
	'click .bgImage' : (e, t) ->
		Meteor.call 'getNextWallpaperId', @name, (error, result) ->
			if error
				console.log error
			Router.go 'wallpaper',
				wallpaper: result