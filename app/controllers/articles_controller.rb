# coding: utf-8
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update, :destroy, :new_from_stockitems, :show ]
  before_action :verify_user_is_owner, only: [:edit, :update, :destroy]

  def index
    @articles = current_user.articles.order(location_id: :asc, title: :asc)
  end

  def show
    # with recaptcha
    @with_contact = user_signed_in? || verify_recaptcha
    # remove the recaptcha error msg
    flash.delete("recaptcha_error")
  end

  def new_from_stockitems
    @categories = Category.all.order({"name_" + I18n.locale.to_s => :asc})
  end

  def create_from_index
    @article = current_user.location.articles.new(article_params)
    respond_to do |format|
      if @article.save
        content = "Title: " + @article.title
        content += "\nDetails: " + @article.details
        UserMailer.admin_content_review_notification_mail(content, article_url(@article)).deliver_now
        format.js { render 'create_success_index'}

      else
        format.js { render 'create_error_index'}
      end
    end
  end

  def create_from_stockitems
    @article = current_user.location.articles.new(article_params)
    respond_to do |format|
      if @article.save
        content = "Title: " + @article.title
        content += "\nDetails: " + @article.details
        UserMailer.admin_content_review_notification_mail(content, article_url(@article)).deliver_now
        format.js { render 'create_success_stockitems'}
      else
        format.js { render 'create_error_stockitems'}
      end
    end
  end

  def update
    @article_div_id = "article-" + @article.id.to_s + "-div" # for js
    params = article_params

    title_need_review = params.key?(:title) && (not params[:title].empty?) && (params[:title] != @article.title)
    if title_need_review
      content = "Title: " + params[:title]
    end

    details_need_review = params.key?(:details) && (not params[:details].empty?) && (params[:details] != @article.details)
    if details_need_review
      unless content
        content = ""
      else
        content += "\n"
      end
      content += "Details: " + params[:details]
    end

    success = @article.update(params)
    respond_to do |format|
      if success
        if title_need_review || details_need_review
          UserMailer.admin_content_review_notification_mail(content, article_url(@article)).deliver_now
        end
        format.js { render 'update_success' }
      else
        format.js { render 'update_error' }
      end
    end
  end

  def destroy
    @article.destroy
    @article_div_id = "article-" + @article.id.to_s + "-div" # for js
    @list_is_empty = current_user.articles.empty?
    respond_to do |format|
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :details, :rate, :location_id, :stockitem_id)
    end

    # use to verify the article really belongs to the current user
    def verify_user_is_owner
      unless current_user.id == @article.user.id
        respond_to do |format|
          flash[:danger] = t('articles.warning_not_owner')
          format.html { redirect_to articles_url }
        end
      end
    end
end
