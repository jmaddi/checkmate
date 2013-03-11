
$(document).ready ->
  $.getJSON('/lift/habits.json', (data) ->
    ko.applyBindings(habits: data)
    $('#habits').select2({width: 300});
  )
