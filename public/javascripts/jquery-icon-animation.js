(function($) {
  /**
  * Toggles the panel icons display, using animation to display and hide the panel icons on a double click event
  *
  * @useage $('span.icons').animateIconPanel()
  *
  * @author Yomi Colledge
  **/
$.fn.animateIconPanel = function(options) {
  var opts = $.extend({}, $.fn.animateIconPanel.defaults, options);

  // Stop the propagation of our event on links
  // @todo Need to resolve our issue with this removing the accordion functionality.
  // $("a[href!='#']").bind('click', function(event) {
  //   event.stopPropagation();
  // });

  // $(this).unbind(opts.eventType);
  $(this).bind(opts.eventType, function(event) {
    var $iconsWrapper = $('ul', this),
        $openLink = $iconsWrapper.parent().find('>span'),
        $panel = $(this);

    console.log($("a[href!='#']"));
    // is list visible
    if ($iconsWrapper.is(':visible') == false) {
      $openLink.fadeOut(opts.speed, function() {
        $panel.addClass(opts.panelClass);
        $iconsWrapper.animate({opacity: 'toggle', height: 'toggle', width: 'toggle', background: opts.mouseoverBgColour}, 'slow');
      });
    } else {
      $iconsWrapper.animate({opacity: 'toggle', height: 'toggle', width: 'toggle', background: opts.mouseoutBgColour}, 'slow', function() {
      $panel.removeClass(opts.panelClass);
        $openLink.fadeIn();
      });
    }
  });

  return $(this).each(function() {
    var $iconList = $('ul.icons', this),
          $innerWrapper = $('<span>')
            .addClass('ui-icon ui-icon-info')
            .css({'float': 'left', 'padding-right': '0.3em'}),
          $innerContent = $('<strong>').append(opts.eventText),
          $content = $('<span> to view panel</span>'),
          $textWrapper = $('<span>')
            .append($innerWrapper)
            .append($innerContent)
            .append($content)
            .addClass(opts.panelTextClass)
            .css({'display': 'block', 'float': 'right'});

    $iconList.hide().parent().removeClass(opts.panelClass);
    $iconList.before($textWrapper);
  });

  // private function for debugging
  function debug($obj) {
    if (window.console && window.console.log) {
      window.console.log($obj);
    }
  }
};

// default options
$.fn.animateIconPanel.defaults = {
  speed:300,
  eventType: 'dblclick',
  eventText: 'Double click',
  panelTextClass: 'view-panel ui-state-highlight',
  panelClass: 'icons ui-widget ui-widget-content ui-corner-all',
  mouseoutBgColour: '#89A407',
  mouseoverBgColour: '#fff'
};

})(jQuery);