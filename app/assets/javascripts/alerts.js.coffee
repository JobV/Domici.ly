ready = ->
  
  options = valueNames: [
    "state"
    "title"
    "assignee"
    "updated_at"
  ]

  alertsTable = new List("alerts-table", options)

  sortname = "updated_at"
  sortorder = "desc"

  $('.sort').click ->
    sortname  = $(this).data("sort")
    alertsTable.sort(sortname,{order: sortorder})
    console.log sortname
    console.log sortorder

  $('.sortorder').click ->
    sortorder = $(this).data("sort")
    alertsTable.sort(sortname,{order: sortorder})
    console.log sortname
    console.log sortorder

$(document).ready(ready)
$(document).on('page:load', ready)
