// Screensaver

$(document).on('turbolinks:load', function() {
  var $el = $('#screensaver');

  if ( !$el.length ) return;

  var url = $el.attr('data-screensaver-path');
  var getImage = function() {
    $.ajax({
      url: url,
      dataType: 'script'
    }).done(function(data) {
      window.setTimeout(function() {
        getImage();
      }, 7000);
    });
  };

  getImage();
});
