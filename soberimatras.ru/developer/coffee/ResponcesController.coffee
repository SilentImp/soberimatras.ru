class ResponcesController
  constructor: ->
    @widget = $ '#page-7 .responces'
    @nav = @widget.find '>nav'
    @responces = @widget.find '.responce:nth-child(2n)'
    @list = $ '.responce-list'
    fragment = document.createDocumentFragment()
    i = 0
    for responce in @responces
      link = document.createElement 'A'
      link.setAttribute 'href', '#responce-'+i
      link.setAttribute 'data-screen', i
      if i==0
        link.className = 'selected'
      $(link).on 'click', @gotoPage
      fragment.appendChild link
      i++
    @nav[0].appendChild fragment
    @current = @nav.find '.selected'
    console.log 'current: ', @current

  gotoPage: (event)=>
    event.preventDefault()
    link = $ event.currentTarget
    screen = $(link).attr 'data-screen'
    @current.removeClass 'selected'
    link.addClass 'selected'
    @current = link
    element = @widget.find('.responce:eq('+screen*2+')')[0]
    @list.stop().scrollTo(element,500)


$(document).ready ->
  new ResponcesController()