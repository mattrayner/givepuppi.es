(function() {
  var Puppys;

  Puppys = (function() {
    function Puppys() {}

    Puppys.toggle_disabled_on_row = function(identifier) {
      console.log("in here");
      console.log(identifier);
      $(identifier).on('ajax:error', function(e, data, status, xhr) {
        console.log("ajax error");
        $(identifier).closest('tr').slideDown();
        return UI.show_error('SOME ERROR TEXT GOES HERE');
      });
      return $(identifier).on('click', function(e) {
        var row;
        console.log("click");
        row = $(this).closest('tr');
        $(row).slideUp();
        return UI.show_undo_helper('SOME UNDO HELPER TEXT GOES HERE', 'UNDO DISABLE', function() {
          return UI.slide_down(row);
        });
      });
    };

    return Puppys;

  })();

  window.Puppys = Puppys;

  jQuery(function() {
    return $('tr a.toggle-disabled[data-remote=\'true\']').each(function() {
      return Puppys.toggle_disabled_on_row(this);
    });
  });

}).call(this);
