class AttendanceManagement.Models.Attendance extends Backbone.Model
  paramRoot: 'attendance'

  defaults:
    working_day: null
    working_time: null
    comment: null

class AttendanceManagement.Collections.AttendancesCollection extends Backbone.Collection
  model: AttendanceManagement.Models.Attendance
  url: '/attendances'
