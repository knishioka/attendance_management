class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:update, :destroy]

  def index
    render json: Attendance.all
  end

  def show
    render json: @attendance
  end

  def create
    @attendance = current_user.attend!(attendance_params)
    if @attendance.valid?
      render json: @attendance
    else
      render json: @attendance.errors, status: 500
    end
  end

  def update
    if @attendance.update(attendance_params)
      render json: @attendance
    else
      render json: @attendance.errors
    end
  end

  def destroy
    @attendance.destroy
    render json: @attendance
  end

  private

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:working_day, :working_time, :comment)
  end
end
