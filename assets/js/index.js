/**
 * Main JS file for Casper behaviours
 */

/*globals jQuery, document */
(function ($) {
    "use strict";
    console.log(window.pageYOffset);
    $(document).ready(function(){
        $.getJSON('/tags', function (tags) {
          var _tags = tags.tags;

          for (var i = _tags.length - 1; i >= 0; i--) {
            var _li = $("<li />").html("<a href='/tag/" + _tags[i].slug + "'>" + _tags[i].name + "</a>");
            _li.appendTo($('#tags-cloud'));

          }
        });

        var hash = location.hash.substring(1);
        var eleName = '*[name=' + hash + ']';
        if (window.pageYOffset === 0 && $(eleName)) {
          $("html,body").animate({scrollTop: $(eleName).offset().top - 100}, 1000);
        }

        $(".post-content").fitVids();

        function casperFullImg() {
            $("img").each( function() {
                var contentWidth = $(".post-content").outerWidth(); // Width of the content
                var imageWidth = $(this)[0].naturalWidth; // Original image resolution

                if (imageWidth >= contentWidth) {
                    $(this).addClass('full-img');
                } else {
                    $(this).removeClass('full-img');
                }
            });
        };

        casperFullImg();
        $(window).smartresize(casperFullImg);

    });

}(jQuery));

(function($,sr){

  // debouncing function from John Hann
  // http://unscriptable.com/index.php/2009/03/20/debouncing-javascript-methods/
  var debounce = function (func, threshold, execAsap) {
      var timeout;

      return function debounced () {
          var obj = this, args = arguments;
          function delayed () {
              if (!execAsap)
                  func.apply(obj, args);
              timeout = null;
          };

          if (timeout)
              clearTimeout(timeout);
          else if (execAsap)
              func.apply(obj, args);

          timeout = setTimeout(delayed, threshold || 100);
      };
  }
  // smartresize 
  jQuery.fn[sr] = function(fn){  return fn ? this.bind('resize', debounce(fn)) : this.trigger(sr); };

})(jQuery,'smartresize');