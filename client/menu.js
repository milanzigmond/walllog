Template.menu.helpers({
	isActive: function (name) {
		return name === Router.current().route.getName();
	}
});