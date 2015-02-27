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
			Roles.addUsersToRoles userid, ["admin"]
		else
			Roles.addUsersToRoles userid, ["regular"]
		
			console.log userid
}
