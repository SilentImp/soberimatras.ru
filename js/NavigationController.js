var NavigationController,
  __bind = function(fn, me) {
    return function() {
      return fn.apply(me, arguments);
    };
  };

NavigationController = (function() {
  function NavigationController() {
    this.scrollPage = __bind(this.scrollPage, this);
    this.navigation = $('.page-navigation');
    if (!this.navigation) {
      return;
    }
    this.navigation.find('a').on('click', this.scrollPage);
  }

  NavigationController.prototype.scrollPage = function(event) {
    var element, link;
    event.preventDefault();
    link = $(event.currentTarget);
    element = $(event.currentTarget.getAttribute('href'))[0];
    return $.localScroll(element);
  };

  return NavigationController;

})();

$(document).ready(function() {
  return new NavigationController();
});
