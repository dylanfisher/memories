// Memory index

$(document).on('turbolinks:load', function() {
  var $memories = $('.memory-index__memory');

  if ( !$memories.length ) return;

  var getRandom = function(arr, n) {
    var result = new Array(n);
    var len = arr.length;
    var taken = new Array(len);
    if (n > len)
      throw new RangeError("getRandom: more elements taken than available");
    while (n--) {
      var x = Math.floor(Math.random() * len);
      result[n] = arr[x in taken ? taken[x] : x];
      taken[x] = --len in taken ? taken[len] : len;
    }
    return result;
  };

  $memories.each(function() {
    var $memory = $(this);
    var $previewArea = $memory.find('.memory-index__preview-area');
    var allUrls = JSON.parse( $memory.attr('data-image-urls') );
    var urls = getRandom(allUrls, Math.min(6, allUrls.length));
    var newElements = [];

    for (var i = urls.length - 1; i >= 0; i--) {
      newElements.push('<div class="col-4 col-md-2"><div class="memory-index__image background-image landscape-image" style="background-image: url(' + urls[i] + ');"></div></div>');
    }

    $previewArea.html(newElements);
  });
});
