Meteor.methods {
	
	addUser: (userData) ->
		if !userData.username or !userData.email or !userData.password
			return

		isAdmin = if Meteor.users.find().count() == 0 then true else false

		userid = Accounts.createUser
			email: userData.email
			password: userData.password
			username: userData.username
			profile:
				newsletter: false
		
		if isAdmin
			Roles.addUsersToRoles userid, ["admin"]
		else
			Roles.addUsersToRoles userid, ["regular"]

	getNextWallpaperId: (wallName) ->
		wallpaperCursor = Wallpapers.find {published:true},
			sort: createdAt: -1
			fields: name: 1
		wallpapers = wallpaperCursor.fetch()
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
	
	countLikesForWallpaperId: (wallId) ->
		Likes.find({wallpaperId: wallId}).count()
}