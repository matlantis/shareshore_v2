class UserMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)
  add_template_helper(DeviseHelper)
  
  def article_request_mail(request)
    @request = request
    to_address = request.article.user.email
    subject = t('.subject', article: request.article.title)
    mail(to: to_address, subject: subject)
  end

  def user_message_mail(message)
    @message = message
    to_address = message.receiver.email
    from = t('.sender', sender: message.sender.nickname)
    subject = t('.subject', sender: message.sender.nickname)
    mail(to: to_address, subject: subject, from: from)
  end

  def receive(email)
    puts "received an email: " + email
  end
end
