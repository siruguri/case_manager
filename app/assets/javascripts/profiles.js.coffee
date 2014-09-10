update_list = (data) ->
	html = "<li><i>" + data['description'] + '</i>, entered on: ' + data['created_at'] + '</li>'
	$(html).hide().appendTo($(".action_list")).fadeIn(400)
	$("#action_desc").val('')

click_add_button_fn = ->
  $("#add_action").click ->
  	$.ajax({
  		url: '/api/v1/profile/list',
  		data: {desc: $("#action_desc").val()},
  		type: 'post',
  		dataType: 'json',
  		success: update_list})

$(document).ready(click_add_button_fn)
$(document).on('page:load', click_add_button_fn)

