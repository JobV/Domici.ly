ready = ->

  options = valueNames: [
    "state"
    "title"
    "assignee"
    "timestamp-hidden"
    "tagfil"
    "assignedfil"
    "ownedfil"
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
  ownedFilter = ''
  assignedFilter = ''

  $('.filter').click ->
    $('.filter').removeClass "active"
    set_filter(this,alertsTable, stateFilter, tagFilter, ownedFilter, assignedFilter)

  $('.tagfilter').click ->
    $('.tagfilter').removeClass "active"
    set_filter(this, alertsTable, stateFilter, tagFilter, ownedFilter, assignedFilter)

  $('.ownedfilter').click ->
    $('.assignedfilter').removeClass "active"
    $('.ownedfilter').removeClass "active"
    set_filter(this, alertsTable, stateFilter, tagFilter, ownedFilter, assignedFilter)

  $('.assignedfilter').click ->
    $('.assignedfilter').removeClass "active"
    $('.ownedfilter').removeClass "active"
    set_filter(this, alertsTable, stateFilter, tagFilter, ownedFilter, assignedFilter)


set_filter = (element, table, stateFilter, tagFilter, ownedFilter, assignedFilter) ->
  $(element).addClass "active"
  stateFilter       = $('.filter.active').data("filter")
  tagFilter         = $('.tagfilter.active').data("filter")
  ownedFilter       = $('.ownedfilter.active').data("filter")
  assignedFilter    = $('.assignedfilter.active').data("filter")

  filter_all(table, stateFilter, tagFilter, ownedFilter, assignedFilter)


filter_all = (table, filter = '', tagfilter = '', ownedfilter = '', assignedfilter = '') ->
  table.filter (item) ->
    if item.values().state.indexOf(filter) > -1 and item.values().tagfil.indexOf(tagfilter) > -1 and item.values().ownedfil.indexOf(ownedfilter) > -1 and item.values().assignedfil.indexOf(assignedfilter) > -1
      true
    else
      false

$(document).ready(ready)
$(document).on('page:load', ready)
