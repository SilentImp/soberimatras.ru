var QuestionController,
  __bind = function(fn, me) {
    return function() {
      return fn.apply(me, arguments);
    };
  };

QuestionController = (function() {
  function QuestionController() {
    this.hideForm = __bind(this.hideForm, this);
    this.showForm = __bind(this.showForm, this);
    this.validate = __bind(this.validate, this);
    this.dataSended = __bind(this.dataSended, this);
    this.hideMessage = __bind(this.hideMessage, this);
    this.send = __bind(this.send, this);
    this.button = $('.ask');
    this.form = $('.question-form');
    this.message = $('.question-asked');
    if (!this.button || !this.message || !this.form) {
      return;
    }
    this.message_close = this.message.find('.close');
    this.submit_button = this.form.find('button');
    this.close = this.form.find('.close');
    this.form.find('[type=tel]').mask("+7 (999) 999-99-99");
    this.button.on('click', this.showForm);
    this.close.on('click', this.hideForm);
    this.submit_button.on('click', this.validate);
    this.form.on('submit', this.send);
    this.message_close.on('click', this.hideMessage);
  }

  QuestionController.prototype.send = function(event) {
    event.preventDefault();
    return $.ajax({
      type: 'POST',
      url: this.form.attr('action'),
      data: this.form.serialize,
      complete: this.dataSended
    });
  };

  QuestionController.prototype.hideMessage = function(event) {
    event.preventDefault();
    return this.message.fadeOut();
  };

  QuestionController.prototype.dataSended = function() {
    this.form.removeClass('open');
    this.form[0].reset();
    this.form.removeClass('validate');
    return this.message.fadeIn();
  };

  QuestionController.prototype.validate = function() {
    return this.form.addClass('validate');
  };

  QuestionController.prototype.showForm = function(event) {
    event.preventDefault();
    return this.form.addClass('open');
  };

  QuestionController.prototype.hideForm = function(event) {
    event.preventDefault();
    return this.form.removeClass('open');
  };

  return QuestionController;

})();

$(document).ready(function() {
  return new QuestionController();
});
