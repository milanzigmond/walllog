showToast = (toast) ->
	Session.set('accountError', toast)
	document.getElementById('toast').show()

showInfo = (message) ->
	document.getElementById('toast').style.background = "#000000"
	showToast(message)

login = (email, password) ->
	Meteor.loginWithPassword email, password, (err) ->
		if err
			showInfo(err.reason)

register = (template) ->
	userData =
		username: template.find('#registerUsername').value
		email: template.find('#registerEmail').value
		password: template.find('#registerPassword').value
	Meteor.call "addUser", userData, (err) ->
		if err
			showInfo(err.reason)
		else
			login(userData.email, userData.password)
			showInfo('Account created. Welcome to family '+userData.username+'! ')

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
