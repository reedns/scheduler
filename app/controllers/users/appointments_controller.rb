class Users::AppointmentsController < ApplicationController
  def index
    appointment_type = %w(upcoming_appointments past_appointments).include?(params[:view]) ? params[:view] : 'upcoming_appointments'
    @next_view, @view_title = params[:view] == 'past_appointments' ? ['upcoming', 'Past'] : ['past', 'Upcoming']
    @user = User.find(params[:user_id])
    @appointments = @user.appointments.includes(:client).send(appointment_type)
  end
end
