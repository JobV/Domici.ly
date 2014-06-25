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

  $('.filter').click ->
    $('.filter').removeClass "active"
    $('.default-filter').removeClass "active"
    $(this).addClass "active"
    filter = $(this).data("filter")
    alertsTable.filter (item) ->
      if item.values().state.indexOf(filter) > -1
        true
      else
        false

  # By default, filter out klaar
  $('.default-filter').click ->
    $('.filter').removeClass "active"
    $(this).addClass "active"
    alertsTable.filter (item) ->
      if item.values().state.indexOf("klaar") > -1
        false
      else
        true



$(document).ready(ready)
$(document).on('page:load', ready)
