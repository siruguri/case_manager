autoc_fn = ->
  $(".autocomplete").autocomplete({
    source: (req, resp) ->
      $.ajax({
        url: '/api/v1/clients',
        data: {q: req.term, fill_in: $(this.element).attr('name')},
        success: resp,
        error: resp})
        
    select: (evt, ui) ->
      $("#form_entry_clients_attributes_0_first_name").val(ui.item.first_name)
      $("#client_last_name").val(ui.item.last_name)
      $("#form_entry_clients_attributes_0_mr_number").val(ui.item.mr_number)
      $("#form_entry_form_cross_references_attributes_0_cross_reference_id").val(ui.item.id)
      $("#form_entry_form_cross_references_attributes_0_cross_reference_type").val('Client')
      $(".enrolment-id").val $(".enrolment-id").val().replace(/\d+$/, ui.item.id)
      null
    })

$(document).ready(autoc_fn)
$(document).on('page:load', autoc_fn)

