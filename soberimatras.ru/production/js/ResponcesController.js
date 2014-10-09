var ResponcesController,
  __bind = function(fn, me) {
    return function() {
      return fn.apply(me, arguments);
    };
  };

ResponcesController = (function() {
  function ResponcesController() {
    this.gotoPage = __bind(this.gotoPage, this);
    var fragment, i, link, responce, _i, _len, _ref;
    this.widget = $('#page-7 .responces');
    this.nav = this.widget.find('>nav');
    this.responces = this.widget.find('.responce:nth-child(2n)');
    this.list = $('.responce-list');
    fragment = document.createDocumentFragment();
    i = 0;
    _ref = this.responces;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      responce = _ref[_i];
      link = document.createElement('A');
      link.setAttribute('href', '#responce-' + i);
      link.setAttribute('data-screen', i);
      if (i === 0) {
        link.className = 'selected';
      }
      $(link).on('click', this.gotoPage);
      fragment.appendChild(link);
      i++;
    }
    this.nav[0].appendChild(fragment);
    this.current = this.nav.find('.selected');
    console.log('current: ', this.current);
  }

  ResponcesController.prototype.gotoPage = function(event) {
    var element, link, screen;
    event.preventDefault();
    link = $(event.currentTarget);
    screen = $(link).attr('data-screen');
    this.current.removeClass('selected');
    link.addClass('selected');
    this.current = link;
    element = this.widget.find('.responce:eq(' + screen * 2 + ')')[0];
    return this.list.stop().scrollTo(element, 500);
  };

  return ResponcesController;

})();

$(document).ready(function() {
  return new ResponcesController();
});
