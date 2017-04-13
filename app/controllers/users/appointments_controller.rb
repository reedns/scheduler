class Users::AppointmentsController < ApplicationController
  def index
    user = @user.find(params[:user_id])
    @appointments = user.appointments.upcoming
  end
end
