class WindowController
  constructor: ->
    @window = $ '#page-1'
    @next_button = @window.find '>nav .next'
    @prev_button = @window.find '>nav .prev'
    @current = @window.find '.selected'
    @next_button.on 'click', @next
    @prev_button.on 'click', @prev

  next: (event)=>
    tmp = @current.next()
    if tmp.length == 0
      tmp = @window.find '.slide:eq(0)'
    @current.removeClass 'selected'
    @current = tmp
    @current.addClass 'selected'

  prev: (event)=>
    tmp = @current.prev()
    if tmp.length == 0
      tmp = @window.find '.slide:last'
    @current.removeClass 'selected'
    @current = tmp
    @current.addClass 'selected'

$(document).ready ->
  new WindowController()