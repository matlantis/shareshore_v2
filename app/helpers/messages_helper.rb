module MessagesHelper
  def mail_subject_user_message(article, user)
    if article
      if user
        subject = t("mail.subject_article_request_username", user: user.nickname, article: article.title)
      else
        subject = t("mail.subject_article_request_anonymous", article: article.title)
      end
    else
      if user
        subject = t("mail.subject_message_username", user: user.nickname)
      else
        subject = t("mail.subject_message_anonymous")
      end
    end
  end

end
