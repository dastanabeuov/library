class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    if current_user.super_admin?
      @users = User.all
    elsif current_user.admin?
      @users = User.all.where("group_id == ?", current_user.group_id)
    else
    end
  end

  def edit
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(@user), notice: "Пользователь успешно создана." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|

      if current_user.admin?
        @user.group_id = current_user.group_id
      end

      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: "Пользователь успешно обновлена." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user.admin? || User.all.where("group_id == ?", current_user.group_id)
      @user.destroy!
      respond_to do |format|
        format.html { redirect_to users_path, notice: "Пользователь успешно удалена." }
        format.json { head :no_content }
      end
    elsif current_user.super_admin?
      @user.destroy!
      respond_to do |format|
        format.html { redirect_to users_path, notice: "Пользователь успешно удалена." }
        format.json { head :no_content }
      end
    else
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :middle_name,
                                 :position, :phone, :active, :role,
                                 :email, :password, :password_confirmation,
                                 :group_id, group_ids: [])
  end
end
