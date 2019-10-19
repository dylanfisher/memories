// Image sequence block

$(document).on('turbolinks:load', function() {
  var timers = [];
  var $blocks = $('.image-sequence-block__images');

  var animate = function($slide, duration) {
    var $next = $slide.nextWrap();

    $slide.removeClass('active');
    $next.addClass('active');

    timers.push(window.setTimeout(function() {
      animate($next, duration);
    }, duration));
  };

  $blocks.each(function() {
    var $block = $(this);
    var $slides = $block.find('.image-sequence-block__image');
    var duration = parseInt( $block.attr('data-duration') );

    if ( $slides.length < 2 ) return;

    animate($slides.first(), duration);
  });

  // TODO: only animate when scrolling into view

  $(document).one('turbolinks:before-cache', function() {
    for (var i = timers.length - 1; i >= 0; i--) {
      if ( timers[i] ) window.clearTimeout(timers[i]);
    }
  });
});
