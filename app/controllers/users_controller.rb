class UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @appointments =  @user.therapist? ? @user.therapist_appts : @user.client_appts
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to user_url, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params[:user]
  end
end
