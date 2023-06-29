class ContactFormRegistrationController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @first_name = params[:contact_form_registration][:first_name]
    @last_name = params[:contact_form_registration][:last_name]
    @middle_name = params[:contact_form_registration][:middle_name]
    @phone = params[:contact_form_registration][:phone]
    @email = params[:contact_form_registration][:email]
    @message = params[:contact_form_registration][:message]

    NotifierMailer.send_user_registration_form(@first_name, @last_name, @middle_name, @phone, @email, @message).deliver_now
    flash[:success] = "Ваше сообщение было отправлено успешно. Наши специалисты свяжутся с вами в ближайшее время."
    redirect_to root_path
  end
end
