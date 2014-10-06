toggle_display = (json_data, refname) ->
    target_classname = '.flag_' + refname
    $(".flag"+target_classname+" span").text(json_data['flag_value'])

click_toggle_flag_button_fn = ->
  $(".toggle-button").click ->
    url = $(this).attr('data-link')
    display_ref = $(this).attr('data-ref')
    $.ajax url: url, type: 'post', dataType: 'json', success: (data, status, xhr) ->
      return toggle_display data, display_ref

$(document).ready(click_toggle_flag_button_fn)
$(document).on('page:load', click_toggle_flag_button_fn)

append_data = (json_data, refname, remove_class) ->
	new_item = $("<li></li>").text("Saved note entry: " + json_data['entry'])
	new_item.appendTo("." + refname)
	$("#" + remove_class).val ''
	null

submit_data_button_fn = ->
	$(".submit-data-button").click ->
		url = $(this).attr('data-link')
		data_class = $(this).attr('input-ref')
		append_class = $(this).attr('append-ref')

		send_data=('entry': $("#" + data_class).val())
		$.ajax url: url, type: 'post', dataType: 'json', data: send_data, success: (resp_data, status, xhr) ->
			return append_data resp_data, append_class, data_class

$(document).ready(submit_data_button_fn)
$(document).on('page:load', submit_data_button_fn)
