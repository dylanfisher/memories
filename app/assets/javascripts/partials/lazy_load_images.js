// Lazy load images

document.addEventListener('lazybeforeunveil', function(e) {
  var bg = e.target.getAttribute('data-bg');

  if ( App && App.breakpoint && App.breakpoint.isMobile() ) {
    var srcMobile = e.target.getAttribute('data-src-mobile');
    var bgSrcMobile = e.target.getAttribute('data-bg-mobile');

    if ( srcMobile ) {
      e.target.setAttribute('data-src', srcMobile);
    }

    if ( bgSrcMobile ) {
      bg = bgSrcMobile;
    }
  }

  if ( bg ) {
    e.target.style.backgroundImage = 'url(' + bg + ')';
  }
});

document.addEventListener('lazybeforeunveil', function(e) {
  $(e.target).closest('.hover-image-effect').addClass('hover-image-effect--lazyloaded');
});

(function() {
  // Disable lazyload if the page being loaded has already been viewed.
  // This prevents the image flashing when it is re-loaded into the document.
  var isPreview = false;

  $(document).on('turbolinks:load', function() {
    isPreview = false
  });

  $(document).on('turbolinks:before-render', function(e) {
    if ( isPreview ) {
      var $newBody = $(e.originalEvent.data.newBody);
      var isMobile = App.breakpoint.isMobile();

      $newBody.find('.lazyload').each(function() {
        var $image = $(this);
        var src = $image.attr('data-src');
        var srcMobile = $image.attr('data-src-mobile');
        var bg = $image.attr('data-bg');
        var bgMobile = $image.attr('data-bg-mobile');

        if ( isMobile ) {
          if ( srcMobile ) src = srcMobile;
          if ( bgMobile ) bg = bgMobile;
        }

        if ( src ) {
          $image
            .removeClass('lazyload')
            .attr('src', src)
            .css({
              transitionDuration: '0s',
              opacity: 1
            });
        } else if ( bg ) {
          $image
            .removeClass('lazyload')
            .css({
              backgroundImage: 'url(' + bg + ')',
              transitionDuration: '0s',
              opacity: 1
            });
        }
      });
    }

    if ( document.documentElement.hasAttribute('data-turbolinks-preview') ) {
      isPreview = true;
    }
  });
})();
