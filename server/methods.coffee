Meteor.methods {
	getNextWallpaperId: (wallName) ->
		wallpaperIdsCursor = Wallpapers.find {published:true},
			sort: createdAt: -1
			fields: name: 1
		wallpapers = wallpaperIdsCursor.fetch()
		names = _.map wallpapers, (wallpaper) ->
			wallpaper.name
		currentNameIndex = names.indexOf wallName
		currentNameIndex++
		if currentNameIndex >= names.length
  		currentNameIndex = 0
  	names[currentNameIndex]
	removeLikes: (wallId) ->
		Likes.remove {
			wallpaperId: wallId
		}
	removeComments: (wallId) ->
		Comments.remove {
			wallpaperId: wallId
		}
}