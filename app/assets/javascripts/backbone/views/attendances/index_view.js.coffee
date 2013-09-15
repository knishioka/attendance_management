AttendanceManagement.Views.Attendances ||= {}

class AttendanceManagement.Views.Attendances.IndexView extends Backbone.View
  template: JST["backbone/templates/attendances/index"]

  initialize: () ->
    @options.attendances.bind('reset', @addAll)

  addAll: () =>
    @options.attendances.each(@addOne)

  addOne: (attendance) =>
    view = new AttendanceManagement.Views.Attendances.AttendanceView({model : attendance})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(attendances: @options.attendances.toJSON() ))
    @addAll()

    return this
