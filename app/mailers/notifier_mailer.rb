class NotifierMailer < ApplicationMailer
  default from: 'feedback@example.kz'

  def send_user_registration_form(first_name, last_name, middle_name, phone, email, message)
    mail(
      "reply-to": email_address_with_name(email, "#{first_name} #{last_name} #{middle_name} #{phone}"),
      subject: "Новое сообщение контактной формы - РЕГИСТРАЦИЯ",
      body: message
    )
  end

  def send_user_qa_form(first_name, email, message)
    mail(
      "reply-to": email_address_with_name(email, "#{first_name}"),
      subject: "Новое сообщение контактной формы - ВОПРОСЫ и ОТВЕТЫ",
      body: message
    )
  end
end
