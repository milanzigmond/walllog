Template.layout.events
	'click paper-item': (e) ->
		# close drawer on mobile after click
		dp = document.getElementById 'drawer-panel'
		dp.closeDrawer()  if dp.selected is "drawer" and dp.narrow
		Router.go $(e.target).attr("label")

Template.layout.helpers
	selected: () ->
		Router.current().route.getName()