Template.stream.events
	'core-animated-pages-transition-prepare core-animated-pages': (e) ->
		# console.log e

	'core-animated-pages-transition-endcore-animated-pages': (e) ->
		# console.log e

	'click core-animated-pages': (e) ->
	  pages = document.querySelector 'core-animated-pages'
	  selectedWallpaperId = pages.selected
	  wallpapers = Wallpapers.find({}, {sort: {createdAt: -1}}).fetch()

	  ids = _.map wallpapers, (wallpaper) ->
	  	wallpaper._id

	  indexOfCurrentWallpaper = ids.indexOf selectedWallpaperId
	  indexOfCurrentWallpaper++
	  indexOfCurrentWallpaper = 0 if indexOfCurrentWallpaper >= ids.length
	  pages.selected = ids[indexOfCurrentWallpaper]

	'change select': (e) ->
		p = document.querySelector('core-animated-pages')
		p.transitions = e.target.value

Template.stream.rendered = () ->
	p = document.querySelector('core-animated-pages')
	wallpapers = Wallpapers.find({}, {sort: {createdAt: -1}}).fetch()
	p.selected = wallpapers[0]._id

Template.stream.helpers
	likesCount: ->
		Likes.find(
			wallpaperId:@_id
		).count()
	commentsCount: ->
		Comments.find(
			wallpaperId:@_id
		).count()
	comments: ->
		Comments.find {wallpaperId:@_id},
			sort:
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