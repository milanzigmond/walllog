Template.games.events
	'click #interactive': (e) ->
		target = e.target
		console.log target 
		unless target.down
		  target.setZ target.z + 1
		  target.style['zIndex'] = target.z
		  if target.z is 5
			  target.down = true
			  target.style["zIndex"] = target.z
		else
		  target.setZ target.z - 1
		  target.style['zIndex'] = target.z
		  target.down = false  if target.z is 0
		  if target.z is 0
			  target.down = false
			  target.style["zIndex"] = target.z