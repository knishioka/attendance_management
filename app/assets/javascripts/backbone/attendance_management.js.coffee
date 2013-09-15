#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.AttendanceManagement =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

attendance_backbone = ->
  window.router = new AttendanceManagement.Routers.AttendancesRouter($('#attendances').data('attendances'));
  Backbone.history.start() unless Backbone.History.started

$(document).ready(attendance_backbone)
$(document).on('page:load', attendance_backbone)
$(document).on 'page:change', ->
  Backbone.history.stop()
  Backbone.history.start() unless Backbone.History.started