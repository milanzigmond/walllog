Meteor.methods {
	addUser: (userData) ->
		isAdmin = if Meteor.users.find().count() == 0 then true else false

		userid = Accounts.createUser
			email: userData.email
			password: userData.password
			username: userData.username
			profile:
				newsletter: false
		
		if isAdmin
			console.log 'isAdmin'
			Roles.addUsersToRoles userid, ["admin"]
			if Wallpapers.find().count() < 1
					console.log 'admin created, creating first wallpaper'
					Wallpapers.insert
						userId: userid
		else
			Roles.addUsersToRoles userid, ["regular"]
		
			console.log userid
}
