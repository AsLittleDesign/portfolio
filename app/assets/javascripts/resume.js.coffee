$ ->
  $("[js-toggle-resume]").click ->
    section = $(this).attr "js-toggle-resume"
    $("[js-toggle-resume]").removeAttr "s-active"
    $(this).attr "s-active", true
    
    $("[js-resume]").removeAttr "s-active"
    $("[js-resume='#{ section }']").attr "s-active", true