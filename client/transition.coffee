createHooks = (options) ->
 
  # Defaults
  options = _.defaults options, {
    alwaysClass: 'animated'
    onscreenClass: ''
    offscreenClass: ''
    removeClass: ''
    removeTimeout: 500
    insertTimeout: 500
  }

  # console.log 'options after defaults: ' + JSON.stringify(options) 
 
  {
    transitioning: false
    insertElement: (node, next) ->
      insert = ->
        $(node).addClass(options.alwaysClass)
        $(node).addClass(options.onscreenClass)
        $(node).insertBefore(next)
        setTimeout finish, options.insertTimeout
 
      finish = -> $(node).removeClass(options.onscreenClass)
 
      if @transitioning
        setTimeout insert, options.removeTimeout
      else
        insert()
 
    removeElement: (node) ->
      remove = =>
        @transitioning = false
        $(node).remove()
 
      if options.removeClass.length
        $(node).addClass(options.alwaysClass)
        $(node).addClass(options.removeClass)
        @transitioning = true
        setTimeout remove, options.removeTimeout
      else
        remove()
  }
 
Template.transition.rendered = ->
  hooks = 
    onscreenClass: @data?.in or 'fadeIn'
    removeClass: @data?.out or 'fadeOut'
    insertTimeout: @data?.timeoutIn or 500
    removeTimeout: @data?.timeoutOut   or 500

  @firstNode.parentNode._uihooks = createHooks(hooks)