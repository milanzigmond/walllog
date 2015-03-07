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
		
			console.log userid
}
