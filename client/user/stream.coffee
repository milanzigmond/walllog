switchToNextWallpaper = () ->
	pages = document.querySelector '#stream'
	selectedWallpaperId = pages.selected
	wallpapers = Wallpapers.find({}, {sort: {createdAt: -1}}).fetch()
	ids = _.map wallpapers, (wallpaper) ->
  	wallpaper._id
  indexOfCurrentWallpaper = ids.indexOf selectedWallpaperId
  indexOfCurrentWallpaper++
  indexOfCurrentWallpaper = 0 if indexOfCurrentWallpaper >= ids.length
  pages.selected = ids[indexOfCurrentWallpaper]

# Template.stream.events
# 	'click .bgImage': (e) ->
# 	  switchToNextWallpaper()
	# 'core-animated-pages-transition-prepare core-animated-pages': (e) ->
		# console.log e
	# 'core-animated-pages-transition-endcore-animated-pages': (e) ->
		# console.log e

Template.stream.rendered = () ->
	p = document.querySelector('#stream')
	wallpapers = Wallpapers.find({}, {sort: {createdAt: -1}}).fetch()
	p.selected = wallpapers[0]._id
