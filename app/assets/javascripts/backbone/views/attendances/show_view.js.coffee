AttendanceManagement.Views.Attendances ||= {}

class AttendanceManagement.Views.Attendances.ShowView extends Backbone.View
  template: JST["backbone/templates/attendances/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
