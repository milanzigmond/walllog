Meteor.startup ->
	console.log 'creating users' + Meteor.users.find().count()
	if Meteor.users.find().count() < 1
		users = [
			{
				name:'Regular User'
				email: 'regular@regular.com'
				roles: [
					'regular'
				]
			}
			{
				name:'Milan Zigmond'
				email: 'milan@milan.com'
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
				username: userData.email,
				profile: {
					name: userData.name
				}
			}
			console.log userid
			Roles.addUsersToRoles userid, userData.roles
	Inject.rawModHtml "addUnresolved", (html) ->
    html = html.replace("<body>", "<body unresolved fullbleed layout vertical>")
  return