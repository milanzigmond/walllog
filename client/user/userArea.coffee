Session.setDefault 'invalidLoginPassword', false
Session.setDefault 'invalidUsername', false
Session.setDefault 'invalidRegisterEmail', false


showToast = (toast) ->
	Session.set('accountError', toast)
	document.getElementById('toast').show()

showInfo = (message) ->
	document.getElementById('toast').style.background = "#000000"
	showToast(message)

showError = (message) ->
	document.getElementById('toast').style.background = "#F44336"
	showToast(message)

showConfirmation = (message) ->
	document.getElementById('toast').style.background = "#4CAF50"
	showToast(message)

login = (email, password) ->
	Meteor.loginWithPassword email, password, (err) ->
		if err
			showError(err.reason)
		else
			showInfo('Welcome back!')

register = (template) ->
	userData =
		username: template.find('#registerUsername').value
		email: template.find('#registerEmail').value
		password: template.find('#registerPassword').value
	Meteor.call "addUser", userData, (err) ->
		if err
			showError(err.reason)
		else
			login(userData.email, userData.password)
			showConfirmation('Account created. Welcome to family! ')

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
