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
#  $(".general_messages").html mesg_str
 
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

page_functions = ->
  $(".glyphicon-expand").css('cursor', 'pointer')
  $(".expand-icon").click (evt) ->
    id=$(evt.target).data('vol-id')
    state=$(evt.target).data('state')
    if state == 'closed' or state==null
      $("#client-list-" + id).show()
      $(evt.target).data('state', 'open')
      $(evt.target).removeClass('glyphicon-expand')
      $(evt.target).addClass('glyphicon-collapse-down')
    else
      $("#client-list-" + id).hide()
      $(evt.target).data('state', 'closed')
      $(evt.target).removeClass('glyphicon-collapse-down')
      $(evt.target).addClass('glyphicon-expand')

$(document).ready(page_functions)
$(document).on('page:load', page_functions)
