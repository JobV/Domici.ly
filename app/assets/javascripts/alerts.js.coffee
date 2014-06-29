ready = ->

  options = valueNames: [
    "state"
    "title"
    "assignee"
    "timestamp-hidden"
    "tagfil"
  ]

  alertsTable = new List("alerts-table", options)

  sortname = "timestamp-hidden"
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

  stateFilter = ''
  tagFilter   = ''

  $('.filter').click ->
    $('.filter').removeClass "active"
    set_filter(this,alertsTable, stateFilter, tagFilter)

  $('.tagfilter').click ->
    $('.tagfilter').removeClass "active"
    set_filter(this, alertsTable, stateFilter, tagFilter)


set_filter = (element, table, stateFilter, tagFilter) ->
  $(element).addClass "active"
  stateFilter = $('.filter.active').data("filter")
  tagFilter   = $('.tagfilter.active').data("filter")
  filter_all(table, stateFilter, tagFilter)


filter_all = (table, filter = '', tagfilter = '') ->
  table.filter (item) ->
    if item.values().state.indexOf(filter) > -1 and item.values().tagfil.indexOf(tagfilter) > -1
      true
    else
      false

$(document).ready(ready)
$(document).on('page:load', ready)
