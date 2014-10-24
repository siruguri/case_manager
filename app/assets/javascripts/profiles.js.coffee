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

message = (mesg_str) ->
  $(".general_messages").html mesg_str
 
cb = (evt, ui) ->
  $.ajax({
      url: '/api/v1/clients/?api_action=set_client_priorities',
      data: {priorities: $(evt.target).sortable( "toArray" )},
      type: 'post',
      dataType: 'json',
      success: message('Client priorities updated')})
 
init_sortable = ->
  $( ".client_sortable" ).sortable({stop: cb})
  $( ".client_sortable" ).disableSelection()
  null

$(document).ready(click_add_button_fn)
$(document).on('page:load', click_add_button_fn)

$(document).ready(init_sortable)
$(document).on('page:load', init_sortable)
