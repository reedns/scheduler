class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /appointments
  def index
    @appointments = policy_scope(Appointment)
  end

  # GET /appointments/1
  def show
    authorize @appointment
    @user = current_user
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  # GET /appointments/1/edit
  def edit
    authorize @appointment
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)
    authorize @appointment

    if @appointment.save
      redirect_to root_path, notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if request.referer.include?('/edit')
      if @appointment.update(appointment_params)
        redirect_to @appointment, notice: 'Appointment was successfully updated.'
      else
        flash[:error] = 'Please fix the errors below.'
        render :edit
      end
    else
      if @appointment.update(appointment_params)
        AppMailer.send_emails(current_user, @appointment)
        redirect_to @appointment, notice: 'Appointment was successfully reserved.'
      else
        @user = current_user
        @appointment.reload
        flash.now[:notice] = 'Please fix the errors below.'
        render :show
      end
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
    authorize @appointment
    redirect_to root_path,
                notice: 'Appointment was successfully deleted.'
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
