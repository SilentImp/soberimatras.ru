class CallbackController
  constructor: ->
    @button = $ '.callback-button'
    @form = $ '.callback-form'
    @secondary_callback = $ '.secondary-callback-form'
    @message = $ '.callback-requested'
    @lightbox = $ 'body>.lightbox'

    if !@button || !@message || !@form || !@secondary_callback
      return

    @message_close = @message.find '.close'
    @submit_button = @form.find 'button'
    @close = @form.find '.close'
    @secondary_callback_submit = @secondary_callback.find 'button'

    @form.find('[type=tel]').mask "+7 (999) 999-99-99"
    @secondary_callback.find('[type=tel]').mask "+7 (999) 999-99-99"

    @button.on 'click', @showForm
    @close.on 'click', @hideForm
    @submit_button.on 'click', @validate
    @form.on 'submit', @send
    @message_close.on 'click', @hideMessage
    @secondary_callback_submit.on 'click', @validateSecondary
    @secondary_callback.on 'submit', @sendSecondary

  sendSecondary: (event)=>
    event.preventDefault()
    $.ajax
      type: 'POST'
      url: @form.attr('action')
      data: @form.serialize
      complete: @dataSendedSecondary

  dataSendedSecondary: =>
    @secondary_callback.removeClass 'validate'
    @secondary_callback[0].reset()
    @lightbox.fadeIn()
    @message.fadeIn()

  send: (event)=>
    event.preventDefault()
    $.ajax
      type: 'POST'
      url: @form.attr('action')
      data: @form.serialize
      complete: @dataSended
    
  hideMessage: (event)=>
    event.preventDefault()
    @message.fadeOut()
    @lightbox.fadeOut()

  dataSended: =>
    @form.removeClass 'open'
    @form.removeClass 'validate'
    @form[0].reset()
    @form.fadeOut()
    @message.fadeIn()

  validateSecondary: =>
    @secondary_callback.addClass 'validate'

  validate: =>
    @form.addClass 'validate'

  showForm: (event)=>
    event.preventDefault()
    @form.fadeIn()
    @lightbox.fadeIn()

  hideForm: (event)=>
    event.preventDefault()
    @form.fadeOut()
    @form[0].reset()
    @form.removeClass 'validate'
    @lightbox.fadeOut()


$(document).ready ->
  new CallbackController()