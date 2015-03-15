createHooks = (options) ->

  options = _.defaults options, {
    alwaysClass: 'animated'
    onscreenClass: ''
    offscreenClass: ''
    removeClass: ''
    removeTimeout: 500
    insertTimeout: 500
  }
 
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
        @transitioning = true
        $(node).addClass(options.alwaysClass)
        $(node).addClass(options.removeClass)
        setTimeout remove, options.removeTimeout
      else
        remove()
  }
 
Template.transition.rendered = ->
  hooks =
    onscreenClass: @data?.animIn or 'fadeIn'
    removeClass: @data?.animOut or 'fadeOut'
    insertTimeout: @data?.timeoutIn or 700
    removeTimeout: @data?.timeoutOut or 300

  # debugger
  @firstNode.parentNode._uihooks = createHooks(hooks)