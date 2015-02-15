Meteor.methods {
	addUser: (userData) ->
		userid = Accounts.createUser {
			email: userData.email
			password: userData.password
			username: userData.username
		}
		console.log userid
		Roles.addUsersToRoles userid, ["regular"]
}
