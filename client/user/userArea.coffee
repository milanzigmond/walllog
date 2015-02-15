login = (email, password) ->
	Meteor.loginWithPassword email, password, (err) ->
		console.log err if err
		# document.getElementById('userArea').selected = "new"

Template.userArea.events
	'click .addUser': (e,t) ->
		t.find('#userArea').selected = "login"
	'click .registerButton.background': (e,t) ->
		t.find('#userArea').selected = "register"
	'click .loginButton.background': (e,t) ->
		t.find('#userArea').selected = "login"
	'click #close': (e,t) ->
		t.find('#userArea').selected = "new"
	'click .loginButton.foreground': (e,t) ->
		login(t.find('#loginEmail').value, t.find('#loginPassword').value)
	'click .registerButton.foreground': (e,t) ->
		userData = {
			username: t.find('#registerUsername').value
			email: t.find('#registerEmail').value
			password: t.find('#registerPassword').value
		}
		Meteor.call "addUser", userData, (err) ->
			login(userData.email, userData.password)
	'keyup #loginPassword' : (e, t) ->
		preventActionsForEvent e
		if e.keyCode is 13
			login(t.find('#loginEmail').value, t.find('#loginPassword').value)
	'keyup #registerPassword' : (e, t) ->
		preventActionsForEvent e
		if e.keyCode is 13
			userData = {
				username: t.find('#registerUsername').value
				email: t.find('#registerEmail').value
				password: t.find('#registerPassword').value
			}
			Meteor.call "addUser", userData, (err) ->
				login(userData.email, userData.password)
