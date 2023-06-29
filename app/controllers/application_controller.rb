class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Доступ запрещен."
    redirect_to books_path
  end

  # def access_denied(exception)
  #   redirect_to root_path, alert: exception.message
  # end
end
