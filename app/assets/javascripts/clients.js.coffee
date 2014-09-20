toggle_display = (json_data, refname) ->
    target_classname = '.flag_' + refname
    $(".flag"+target_classname+" span").text(json_data['flag_value'])

click_add_button_fn = ->
  $(".api-button").click ->
    url = $(this).attr('data-link')
    display_ref = $(this).attr('data-ref')
    $.ajax url: url, type: 'post', dataType: 'json', success: (data, status, xhr) ->
      return toggle_display data, display_ref

$(document).ready(click_add_button_fn)
$(document).on('page:load', click_add_button_fn)

