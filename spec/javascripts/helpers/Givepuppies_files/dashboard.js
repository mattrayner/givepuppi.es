(function() {
  var UI;

  UI = (function() {
    function UI() {}

    UI.show_error = function(error_text) {
      return console.log(error_text);
    };

    UI.hide_error = function() {
      return console.log("HIDE ERROR TEXT");
    };

    UI.show_undo_helper = function(helper_text, callback_text, callback) {
      return console.log('helper: ' + helper_text + '\ncallback: ' + callback_text + '\nfunc: ' + callback + '\n\n' + helper_text + '. ' + callback_text);
    };

    UI.slide_down = function(element) {
      return console.log('slide down');
    };

    return UI;

  })();

  window.UI = UI;

}).call(this);
