// Generated by CoffeeScript 1.9.0
var WebUi;

WebUi = (function() {
  function WebUi() {}

  WebUi.prototype.startTicTacToe = function() {
    return $('[data-slot=one]').bind("click", function(event) {
      return $('[data-slot=one]').val("O");
    });
  };

  return WebUi;

})();