var CallbackController,
  __bind = function(fn, me) {
    return function() {
      return fn.apply(me, arguments);
    };
  };

CallbackController = (function() {
  function CallbackController() {
    this.hideForm = __bind(this.hideForm, this);
    this.showForm = __bind(this.showForm, this);
    this.validate = __bind(this.validate, this);
    this.validateSecondary = __bind(this.validateSecondary, this);
    this.dataSended = __bind(this.dataSended, this);
    this.hideMessage = __bind(this.hideMessage, this);
    this.send = __bind(this.send, this);
    this.dataSendedSecondary = __bind(this.dataSendedSecondary, this);
    this.sendSecondary = __bind(this.sendSecondary, this);
    this.button = $('.callback-button');
    this.form = $('.callback-form');
    this.secondary_callback = $('.secondary-callback-form');
    this.message = $('.callback-requested');
    this.lightbox = $('body>.lightbox');
    if (!this.button || !this.message || !this.form || !this.secondary_callback) {
      return;
    }
    this.message_close = this.message.find('.close');
    this.submit_button = this.form.find('button');
    this.close = this.form.find('.close');
    this.secondary_callback_submit = this.secondary_callback.find('button');
    this.form.find('[type=tel]').mask("+7 (999) 999-99-99");
    this.secondary_callback.find('[type=tel]').mask("+7 (999) 999-99-99");
    this.button.on('click', this.showForm);
    this.close.on('click', this.hideForm);
    this.submit_button.on('click', this.validate);
    this.form.on('submit', this.send);
    this.message_close.on('click', this.hideMessage);
    this.secondary_callback_submit.on('click', this.validateSecondary);
    this.secondary_callback.on('submit', this.sendSecondary);
  }

  CallbackController.prototype.sendSecondary = function(event) {
    event.preventDefault();
    return $.ajax({
      type: 'POST',
      url: this.form.attr('action'),
      data: this.form.serialize,
      complete: this.dataSendedSecondary
    });
  };

  CallbackController.prototype.dataSendedSecondary = function() {
    this.secondary_callback.removeClass('validate');
    this.secondary_callback[0].reset();
    this.lightbox.fadeIn();
    return this.message.fadeIn();
  };

  CallbackController.prototype.send = function(event) {
    event.preventDefault();
    return $.ajax({
      type: 'POST',
      url: this.form.attr('action'),
      data: this.form.serialize,
      complete: this.dataSended
    });
  };

  CallbackController.prototype.hideMessage = function(event) {
    event.preventDefault();
    this.message.fadeOut();
    return this.lightbox.fadeOut();
  };

  CallbackController.prototype.dataSended = function() {
    this.form.removeClass('open');
    this.form.removeClass('validate');
    this.form[0].reset();
    this.form.fadeOut();
    return this.message.fadeIn();
  };

  CallbackController.prototype.validateSecondary = function() {
    return this.secondary_callback.addClass('validate');
  };

  CallbackController.prototype.validate = function() {
    return this.form.addClass('validate');
  };

  CallbackController.prototype.showForm = function(event) {
    event.preventDefault();
    this.form.fadeIn();
    return this.lightbox.fadeIn();
  };

  CallbackController.prototype.hideForm = function(event) {
    event.preventDefault();
    this.form.fadeOut();
    this.form[0].reset();
    this.form.removeClass('validate');
    return this.lightbox.fadeOut();
  };

  return CallbackController;

})();

$(document).ready(function() {
  return new CallbackController();
});
