class QuestionController
  constructor: ->
    @button = $ '.ask'
    @form = $ '.question-form'
    @message = $ '.question-asked'

    if !@button || !@message || !@form
      return

    @message_close = @message.find '.close'
    @submit_button = @form.find 'button'
    @close = @form.find '.close'

    @form.find('[type=tel]').mask "+7 (999) 999-99-99"

    @button.on 'click', @showForm
    @close.on 'click', @hideForm
    @submit_button.on 'click', @validate
    @form.on 'submit', @send
    @message_close.on 'click', @hideMessage

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

  dataSended: =>
    @form.removeClass 'open'
    @form[0].reset()
    @form.removeClass 'validate'
    @message.fadeIn()

  validate: =>
    @form.addClass 'validate'

  showForm: (event)=>
    event.preventDefault()
    @form.addClass 'open'

  hideForm: (event)=>
    event.preventDefault()
    @form.removeClass 'open'


$(document).ready ->
  new QuestionController()