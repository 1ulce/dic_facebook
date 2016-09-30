ready = ->
  $(window).scroll ->
    element = $('#page-top-btn')
    visible = element.is(':visible')
    height = $(window).scrollTop()
    if height > 400
      element.fadeIn() if !visible
    else
      element.fadeOut()
  $(document).on 'click', '#move-page-top', ->
    $('html, body').animate({ scrollTop: 0 }, 'slow')
  $(document).on 'click', '.close', ->
    $(".alert").stop().fadeOut("slow");
  $(document).on 'click', '.conversation-back', ->
    $(".conversation-area").fadeOut("fast");
$(document).ready(ready)
$(document).on('page:load', ready)