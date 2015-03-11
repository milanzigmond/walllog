this.preventActionsForEvent = (event) ->
  event.preventDefault()
  event.stopPropagation()