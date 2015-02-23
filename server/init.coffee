Meteor.startup ->
	# if Meteor.users.find().count() < 1
	# 	users = [
	# 		{
	# 			username: 'milanzigmond'
	# 			email: 'milanzigmond@gmail.com'
	# 			newsletter: true
	# 			roles: [
	# 				'admin'
	# 			]
	# 		}
	# 		{
	# 			username: 'regular'
	# 			email: 'regular@regular.com'
	# 			newsletter: true
	# 			roles: [
	# 				'regular'
	# 			]
	# 		}
	# 	]
	# 	_.each users, (userData) ->
	# 		userid = Accounts.createUser {
	# 			email: userData.email,
	# 			password: 'zigmond'
	# 			username: userData.username
	# 			profile: {
	# 				newsletter: userData.newsletter
	# 			}
	# 		}
	# 		Roles.addUsersToRoles userid, userData.roles
	# 		# first wallpaper
	# 		console.log 'seting up users OUT: '+userid
	# 		if Wallpapers.find().count() < 1
	# 				console.log 'seting up users IN: '+userid
	# 				Wallpapers.insert
	# 					file: ""
	# 					userId: userid
	Inject.rawModHtml "addUnresolved", (html) ->
    html = html.replace("<body>", "<body unresolved fullbleed layout vertical>")