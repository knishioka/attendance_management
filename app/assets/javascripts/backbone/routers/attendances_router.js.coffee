class AttendanceManagement.Routers.AttendancesRouter extends Backbone.Router
  initialize: (options) ->
    @attendances = new AttendanceManagement.Collections.AttendancesCollection()
    @attendances.reset options.attendances

  routes:
    "new"      : "newAttendance"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newAttendance: ->
    @view = new AttendanceManagement.Views.Attendances.NewView(collection: @attendances)
    $("#attendances").html(@view.render().el)

  index: ->
    @view = new AttendanceManagement.Views.Attendances.IndexView(attendances: @attendances)
    $("#attendances").html(@view.render().el)

  show: (id) ->
    attendance = @attendances.get(id)

    @view = new AttendanceManagement.Views.Attendances.ShowView(model: attendance)
    $("#attendances").html(@view.render().el)

  edit: (id) ->
    attendance = @attendances.get(id)

    @view = new AttendanceManagement.Views.Attendances.EditView(model: attendance)
    $("#attendances").html(@view.render().el)
