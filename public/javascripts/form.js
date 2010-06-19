$(document).ready(function() {

  $('form').submit(function() {
    var postData = $(this).serialize();
    $.post($(this).attr('action'), postData, null, "script");
    return false;
  });

  $("a.display_form").live("click",function(event) {
    var link = $(this);
    var id_attribute_name = link.attr('id').split('_');
    var title_array = link.text().split(' ');

    $('form').toggle(function() {
      if('view' == link.text().substr(0,4)) {
        link.text('hide ' + title_array[1]);
      } else {
        link.text('view ' + title_array[1]);
      }
    });
  });

  $.fn.customValidations = function(options) {
    var opts = $.extend({}, $.fn.animateIconPanel.defaults, options);
    $(this).validate({
      ignoreTitle: true,
      focusInvalid: true,
      clearFocus: true,
      successClass: 'valid',
      errorClass: 'error ui-state-error',
      errorElement: "span",
      highlight: function(element, errorClass, validClass) {
       $(element).addClass(errorClass).removeClass(validClass);
       $(element).fadeOut(function() {
         var $parent = $(element).parent();
         var $validElements = $parent.find('span.valid');
         $validElements.remove();

         $parent.addClass(errorClass).removeClass(validClass);
         $(element).show();
       });
      },
      unhighlight: function(element, errorClass, validClass) {
        var $parent = $(element).parent();
        var $validElements = $parent.find('span.error');
        $validElements.html('');

        $(element).removeClass(errorClass).addClass(validClass);
        $validElements.removeClass(errorClass).addClass(validClass);
        $parent.removeClass(errorClass).addClass(validClass);
      },
      success: function(label) {
        var $parent = $(label).parent();
        var $validElements = $parent.find('span.valid');

        $validElements.remove();
        label.removeClass('error ui-state-error').addClass("valid");
      },
      errorPlacement: function(error, element) {
        var $warningSpan = $('<span></span')
                          .css({'float': 'left', 'margin': '0.3em', 'padding-left': '5px'})
                          .addClass('ui-icon invalid'),
            $parent = element.parent(),
            $previousError = $parent.find('span.error');

        if ($previousError.html() == null) {
          error
            .wrap("<span class='ui-state-error ui-corner-all'></span>")
            .insertAfter(element)
            .prepend($warningSpan);
        } else {
          $previousError.show();
        }
      },
      rules: opts.rules
    });
  }
  $('fieldset.inputs > ol li').generateFormatasticTooltips();
});