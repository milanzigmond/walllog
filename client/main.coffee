# Template.main.events
# 	'core-animated-pages-transition-prepare core-animated-pages': (e) ->
# 		# console.log e

# 	'core-animated-pages-transition-endcore-animated-pages': (e) ->
# 		# console.log e

# 	'click core-animated-pages': (e) ->
# 	  p = document.querySelector('core-animated-pages')
# 	  page = e.target.firstElementChild.textContent
# 	  console.log page
# 	  page = '0' if page is '5'
# 	  p.selected = page

# 	'change select': (e) ->
# 		p = document.querySelector('core-animated-pages')
# 		p.transitions = e.target.value

# Template.main.rendered = () ->
# 	p = document.querySelector('core-animated-pages')
# 	p.selected = 0
	
# Template.main.helpers
# 	sections: () ->
# 		[
# 		  {
# 		    page: 1
# 		    width: '25%'
# 		    height: '25%'
# 		    color: 'red'
# 		  }
# 		  {
# 		    page: 2
# 		    width: '100%'
# 		    height: '50%'
# 		    color: 'blue'
# 		  }
# 		  {
# 		    page: 3
# 		    width: '100%'
# 		    height: '100%'
# 		    color: 'purple'
# 		  }
# 		  {
# 		    page: 4
# 		    width: '50%'
# 		    height: '75%'
# 		    color: 'orange'
# 		  }
# 		  {
# 		    page: 5
# 		    width: '10%'
# 		    height: '100%'
# 		    color: 'green'
# 		  }
# 		]
