
$(document).ready ->
  $.getJSON('/lift/habits.json', (data) ->
    ko.applyBindings(habits: data)
  )
