class ContactFormQaController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @first_name = params[:contact_form_qa][:first_name]
    @email = params[:contact_form_qa][:email]
    @message = params[:contact_form_qa][:message]

    NotifierMailer.send_user_qa_form(@first_name, @email, @message).deliver_now
    flash[:success] = "Ваше сообщение было отправлено успешно. Наши специалисты свяжутся с вами в ближайшее время."
    redirect_to main_pages_help_path
  end
end
