AttendanceManagement.Views.Attendances ||= {}

class AttendanceManagement.Views.Attendances.NewView extends Backbone.View
  template: JST["backbone/templates/attendances/new"]

  events:
    "submit #new-attendance": "save"
    "click #working_day": "showCalendar"
    "click .date-choice": "hideCalendar"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (attendance) =>
        @model = attendance
        window.location.hash = "/#{@model.id}"

      error: (attendance, jqXHR) =>
        alert "不正な入力です"
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this

  formattedDate = (date) ->
    date_str = "#{date.getFullYear()}-#{date.getMonth() + 1}-#{date.getDate()}"
    return "<span class='date-choice' data-date='#{date_str}'>#{date_str}</span>"

  showCalendar: (e) ->
    $('#working_day').attr('readonly', true)
    date = new Date()
    $('#calendar').html(formattedDate(date))
    _(7).times ->
      date.setDate(date.getDate() - 1)
      $('#calendar').append(formattedDate(date))
    $('#calendar').show()

  hideCalendar: (e) ->
    console.log $(e.target).data('date')
    $('#working_day').val($(e.target).data('date'))
    this.model.set({ working_day: $(e.target).data('date') })
    $('#calendar').hide()
    $('#working_day').attr('readonly', false)

