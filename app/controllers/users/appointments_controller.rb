class Users::AppointmentsController < ApplicationController
  def index
    appointment_type = %w(upcoming past).include?(params[:view]) ? params[:view] : 'upcoming'
    @next_view, @view_title = params[:view] == 'past' ? ['upcoming', 'Past'] : ['past', 'Upcoming']
    @user = User.find(params[:user_id])
    @appointments = @user.appointments.includes(:client).send(appointment_type)
  end
end
