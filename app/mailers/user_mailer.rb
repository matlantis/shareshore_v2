class UserMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)
  add_template_helper(DeviseHelper)

  def article_request_mail(request)
    @request = request
    to_address = request.article.user.email
    from = t('.sender', sender: request.user.nickname)
    reply_to = "msg_" + request.user.public_uuid + "_" + request.article.user.private_uuid + "@userreply.shareship.de"
    subject = t('.subject', article: request.article.title)
    mail(to: to_address, subject: subject, from: from, reply_to: reply_to)
  end

  def user_message_mail(message)
    @message = message
    to_address = message.receiver.email
    from = t('.sender', sender: message.sender.nickname)
    reply_to = "msg_" + message.sender.public_uuid + "_" + message.receiver.private_uuid + "@userreply.shareship.de"
    if message.subject && !message.subject.blank?
      subject = message.subject
    else
      subject = t('.subject', sender: message.sender.nickname)
    end
    mail(to: to_address, subject: subject, from: from, reply_to: reply_to)
  end

  def admin_content_review_notification_mail(content, link_to_edit)
    @content = content
    @link_to_edit = link_to_edit
    mail(to: 'mail@shareship.de', subject: t('.subject'), from: 'mail@shareship.de')
  end

  def receive(email)
    puts "received an email: " + email
  end
end
