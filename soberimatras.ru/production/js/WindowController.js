var WindowController,
  __bind = function(fn, me) {
    return function() {
      return fn.apply(me, arguments);
    };
  };

WindowController = (function() {
  function WindowController() {
    this.prev = __bind(this.prev, this);
    this.next = __bind(this.next, this);
    this.window = $('#page-1');
    this.next_button = this.window.find('>nav .next');
    this.prev_button = this.window.find('>nav .prev');
    this.current = this.window.find('.selected');
    this.next_button.on('click', this.next);
    this.prev_button.on('click', this.prev);
  }

  WindowController.prototype.next = function(event) {
    var tmp;
    tmp = this.current.next();
    if (tmp.length === 0) {
      tmp = this.window.find('.slide:eq(0)');
    }
    this.current.removeClass('selected');
    this.current = tmp;
    return this.current.addClass('selected');
  };

  WindowController.prototype.prev = function(event) {
    var tmp;
    tmp = this.current.prev();
    if (tmp.length === 0) {
      tmp = this.window.find('.slide:last');
    }
    this.current.removeClass('selected');
    this.current = tmp;
    return this.current.addClass('selected');
  };

  return WindowController;

})();

$(document).ready(function() {
  return new WindowController();
});
