Session.setDefault 'invalidLoginPassword', false
Session.setDefault 'invalidUsername', false
Session.setDefault 'invalidRegisterEmail', false

login = (email, password) ->
	if !email or !password
		return
	Meteor.loginWithPassword email, password, (err) ->
		if err
			console.log err
			if err.reason == "Match failed"
				document.getElementById('userArea').selected = "register"
				$('#registerEmail').val(email)
			if err.reason == "User not found"
				document.getElementById('userArea').selected = "register"
				$('#registerEmail').val(email)
			if err.reason == "Incorrect password"
				Session.set('invalidLoginPassword', true)

register = (template) ->
	userData =
		username: template.find('#registerUsername').value
		email: template.find('#registerEmail').value
		password: template.find('#registerPassword').value
	if !userData.username or !userData.email or !userData.password
		return
	Meteor.call "addUser", userData, (err) ->
		if err
			console.log err
			if err.reason == "Username already exists."
				Session.set 'invalidUsername', true
			if err.reason == "Email already exists."
				Session.set 'invalidRegisterEmail', true
		else
			login(userData.email, userData.password)

Template.userArea.helpers
	invalidLoginPassword: () ->
		Session.get('invalidLoginPassword')
	invalidUsername: () ->
		Session.get('invalidUsername')
	invalidRegisterEmail: () ->
		Session.get('invalidRegisterEmail')

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
		email = t.find('#loginEmail').value
		password = t.find('#loginPassword').value
		login(email,password)
	'click .registerButton.foreground': (e,t) ->
		register(t)
	'keyup #loginPassword' : (e,t) ->
		preventActionsForEvent e
		Session.set 'invalidLoginPassword', false
		if e.keyCode is 13
			email = t.find('#loginEmail').value
			password = t.find('#loginPassword').value
			login(email,password)
	'keyup #registerUsername' : (e,t) ->
		Session.set 'invalidUsername', false
	'keyup #registerEmail' : (e,t) ->
		Session.set 'invalidRegisterEmail', false
	'keyup #registerPassword' : (e,t) ->
		preventActionsForEvent e
		if e.keyCode is 13
			register(t)
