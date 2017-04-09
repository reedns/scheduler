class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @appointments = policy_scope(Appointment.includes(:client))
  end

  def edit
    @user = current_user
    @appointment = Appointment.find(params[:id])
  end

  def update
    @user = current_user
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      AppMailer.send_emails(current_user, @appointment)
      redirect_to root_path,
      notice: "Appointment was succesfully #{@appointment.reserved ? 'reserved' : 'cancelled' }."
    else
      flash.now[:error] = 'Please fix the errors below.'
      @appointment.reload
      render :edit
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:reserved, :reservation_time, :client_id, :cancelled_id)
  end
end
