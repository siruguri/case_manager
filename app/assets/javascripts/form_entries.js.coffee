autoc_fn = ->
  $(".autocomplete").autocomplete({
    source: (req, resp) ->
      $.ajax({
        url: '/api/v1/clients',
        data: {q: req.term, fill_in: $(this.element).attr('name')},
        success: resp,
        error: resp})
        
    select: (evt, ui) ->
      $("#client_first_name").val(ui.item.first_name)
      $("#client_last_name").val(ui.item.last_name)
      $("#client_mr_number").val(ui.item.mr_number)
      $("#client_id").val(ui.item.id)
      $(".enrolment-id").val $(".enrolment-id").val().replace(/\d+$/, ui.item.id)
      null
    })

$(document).ready(autoc_fn)
$(document).on('page:load', autoc_fn)

