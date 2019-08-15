// Google analytics

$(document).on('turbolinks:load', function(e) {
  // Register Google Analytics pageview
  if ( typeof gtag === 'function' && App.googleAnalyticsConfig ) {
    var pageLocation;

    if ( e.originalEvent && e.originalEvent.data && e.originalEvent.data.url ) {
      pageLocation = e.originalEvent.data.url;
    } else {
      pageLocation = window.location.href;
    }

    dataLayer.push({
      event: 'pageview',
      virtualUrl: pageLocation
    });

    for (var i = 0; i < App.googleAnalyticsConfig.length; i++) {
      gtag('config', App.googleAnalyticsConfig[i], { 'page_location': pageLocation });
    }
  }
});
