(function($) {
  /**
  * Plugin to help determine the position of a given element, making sure that it is always at the top of the page.
  *
  * @useage $('div ul').autoScroller({scrollSpeed: 500, height: 500, stopOnHover: true})
  *
  * @author Yomi Colledge
  **/
$.fn.autoScroller = function(options) {
  var opts = $.extend({}, $.fn.autoScroller.defaults, options);
  var width = $(this).parent().width(),
      $innerUnorderedList = $(this).find('ul'),
      previousOffset = null;

  $innerUnorderedList.css('max-height', opts.height)
                     .css('overflow-y', 'hidden');

  $(this).parent().css('width', width);

  if (opts.stopOnHover) {
    $('div#sidebar > ul').live('mouseout mouseover', function(event) {
      stop = (event.type == 'mouseover')? true : false;
    });
  }

  if ($(this).is(':visible')) {
    var stop = false,
        previousOffset = null;

    $innerUnorderedList.scrollTop(0);
    $("#item-list-top").remove();
    $("#item-list-bottom").remove();
    if (parseInt($('ul.hover li:visible').height()) >= 250) {
      $('ul.hover li:visible > hr:first').before("<div id=item-list-top />");
      $('ul.hover li:visible > hr:last').before("<div id=item-list-bottom />");
      $('body').mouseout(function() {stop = true;}).mouseover(function() {stop = false;});

      setInterval(function() {

        if (false == stop) {
          if ($innerUnorderedList.scrollTop() == previousOffset && null != previousOffset) {
            $innerUnorderedList.animate({scrollTop: 0}, 'slow');
            previousOffset = null;
          } else {
            $innerUnorderedList.animate({scrollTop: $innerUnorderedList.scrollTop() + 2}, 5);
          }

          previousOffset = $innerUnorderedList.scrollTop();
    
        }
      }, opts.speed);
    };
  }

  // private function for debugging
  function debug($obj) {
    if (window.console && window.console.log) {
      window.console.log($obj);
    }
  }
};

// default options
$.fn.autoScroller.defaults = {
  speed:500,
  height:200,
  stopOnHover: false
};

})(jQuery);