# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  ## From Super_Admin is created users
  before_action :authenticate_user!, :redirect_unless_super_admin,  only: [:new, :create, :import]
  skip_before_action :require_no_authentication

  # GET /resource/sign_up
  def new
    super
  end

  def import
    count = User.count

    User.start_import(params[:file], group, current_user)

    redirect_to new_user_registration_path

    if User.all.count > count
      flash[:notice] = 'Пользователи импортированы.'
    else
      flash[:error] = 'Пользователи не импортированы.'
    end
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def redirect_unless_super_admin
    unless current_user.try(:super_admin?) || current_user.try(:admin?)
      redirect_to root_path
      flash[:error] = "Только Супер Админы могут это сделать."
    end
  end

  def sign_up(resource_name, resource)
    true
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation,
                                                       :first_name, :last_name, :middle_name, :position,
                                                       :phone, :active, :role, :group_id, group_ids: []])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation,
                                                              :first_name, :last_name, :middle_name, :position,
                                                              :phone, :active, :role, :group_id, group_ids: []])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
