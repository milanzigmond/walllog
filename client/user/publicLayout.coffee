Template.publicLayout.rendered = () ->
	NProgress.configure {
		showSpinner: false
		template: '<div class="bar" role="bar"></div><div class="spinner" role="spinner"><div class="spinner-icon"></div></div>'
	}