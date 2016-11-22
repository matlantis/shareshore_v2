class UserMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)
  add_template_helper(DeviseHelper)
  
  def article_request_mail(request)
    @request = request
    to_address = request.article.user.email
    subject = t('.subject', article: request.article.title)
    mail(to: to_address, subject: subject)
  end
end
