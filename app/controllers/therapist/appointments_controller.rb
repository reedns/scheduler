class Therapist::AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_therapist

  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  def edit
    authorize @appointment
  end

  def create
    @appointment = Appointment.new(appointment_params)
    authorize @appointment

    if @appointment.save
      redirect_to root_path, notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to edit_appointment_path(@appointment), notice: 'Appointment was successfully updated.'
    else
      flash[:error] = 'Please fix the errors below.'
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    authorize @appointment
    redirect_to root_path, notice: 'Appointment was successfully deleted.'
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:date, :start_time, :end_time,
                                        :reserved, :therapist_id, :client_id,
                                        :reservation_time, :cancelled_id)
  end
end
