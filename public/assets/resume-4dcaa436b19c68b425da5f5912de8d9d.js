(function() {
  $(function() {
    return $("[js-toggle-resume]").click(function() {
      var section;
      section = $(this).attr("js-toggle-resume");
      $("[js-toggle-resume]").removeAttr("s-active");
      $(this).attr("s-active", true);
      $("[js-resume]").removeAttr("s-active");
      return $("[js-resume='" + section + "']").attr("s-active", true);
    });
  });

}).call(this);
