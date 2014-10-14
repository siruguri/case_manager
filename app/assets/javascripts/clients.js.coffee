# /* For toggling the flags */

toggle_display = (json_data, refname) ->
    target_classname = '.flag_' + refname
    $(".flag"+target_classname+" span").text(json_data['flag_value'])

click_toggle_flag_button_fn = (evt, state) ->
    url = $(this).attr('data-link')
    display_ref = $(this).attr('data-ref')
    $.ajax url: url, type: 'post', dataType: 'json', success: (data, status, xhr) ->
      return toggle_display data, display_ref

# /* For adding notes */
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

turn_on_bootstrap_switch = ->
	$('input[name="attention-flag"]').bootstrapSwitch()
	$('input[name="attention-flag"]').on('switchChange.bootstrapSwitch', click_toggle_flag_button_fn)
	null

$(document).ready(turn_on_bootstrap_switch)
$(document).on('page:load', turn_on_bootstrap_switch)

# For the tabs
manage_tabs = -> 
	$(".tabs .tab-links a").click -> 
        currentAttrValue = $(this).attr('tabref')
        $(".tab-content .tab" + currentAttrValue).show().siblings().hide()
        $(this).parent('.tab-header').addClass('active').siblings().removeClass('active')
        null

$(document).on('page:load', manage_tabs)
$(document).ready(manage_tabs)
