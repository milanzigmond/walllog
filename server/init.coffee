Meteor.startup ->
	console.log 'creating users' + Meteor.users.find().count()
	if Meteor.users.find().count() < 1
		users = [
			{
				username: 'regular'
				email: 'regular@regular.com'
				newsletter: true
				roles: [
					'regular'
				]
			}
			{
				username: 'milanzigmond'
				email: 'milanzigmond@gmail.com'
				newsletter: true
				roles: [
					'admin'
				]
			}
		]
		console.log 'idem loopovat'
		_.each users, (userData) ->
			userid = Accounts.createUser {
				email: userData.email,
				password: 'zigmond'
				username: userData.username
			}
			Roles.addUsersToRoles userid, userData.roles
	Inject.rawModHtml "addUnresolved", (html) ->
    html = html.replace("<body>", "<body unresolved fullbleed layout vertical>")