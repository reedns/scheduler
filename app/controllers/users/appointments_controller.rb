class Users::AppointmentsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @appointments = user.appointments.includes(:client).upcoming_appointments
  end
end
