jQuery ->
  $('#goal_title_selected').autocomplete
    source: $('#goal_title_selected').data('autocomplete-source')