// Video tag placeholders avoid an issue related to turbolinks and videos that
// continue to play during page navigation.
// https://github.com/turbolinks/turbolinks/issues/177

$(document).on('turbolinks:load', function() {
  var $placeholders = $('.lazy-video-placeholder');

  var turnOffEventListeners = function() {
    $(window).off('resize.lazyLoadVideo scroll.lazyLoadVideo');
  };

  if ( !$placeholders.length ) {
    return;
  } else {
    turnOffEventListeners();
  }

  $placeholders.each(function() {
    var $placeholder = $(this);
    var videoHTML = $placeholder.attr('data-video-tag-html');
    var $video = $(videoHTML);
    var video = $video.get(0);
    var srcFull = $video.attr('data-src');
    var srcMobile = $video.attr('data-src-mobile');
    var src;

    if ( App.breakpoint.isMobile() && srcMobile ) {
      src = srcMobile;
    } else {
      src = srcFull;
    }

    $video.addClass('lazy-video').attr('src', src);
    $placeholder.hide().after($video);

    $video.trigger('app:lazy-loaded');
  });

  var $videos = $('.lazy-video');

  var checkForVisibility = function() {
    $videos.each(function() {
      var $video = $(this);
      var autoplay = $video.attr('autoplay');

      if ( !autoplay || autoplay == 'false' ) {
        $video.data('lazy-load-video-autoplay-disabled', true);
        return;
      }

      if ( App.inViewport(this) ) {
        this.play();
      } else {
        this.pause();
      }
    });
  };

  checkForVisibility();

  $(window).on('resize.lazyLoadVideo', $.debounce( 500, function() {
    checkForVisibility();
  }));

  $(window).on('scroll.lazyLoadVideo', $.throttle( 500, function() {
    checkForVisibility();
  }));

  $(document).one('turbolinks:before-cache', function() {
    $videos.each(function() {
      this.pause();
      this.src = '';
      $(this).remove().length = 0;
    });

    turnOffEventListeners();
  });

  var $disabledVideos = $placeholders.filter(function() {
    return $(this).data('lazy-load-video-autoplay-disabled') == true;
  });

  if ( $placeholders.length == $disabledVideos.length ) {
    turnOffEventListeners();
  }
});
