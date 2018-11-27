class UserArticleRequestsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  # POST /user_article_requests
  # POST /user_article_requests.json
  def create
    @request = UserArticleRequest.new(user_article_request_params)
    @request.user = current_user

    respond_to do |format|
      if @request.save
        UserMailer.article_request_mail(@request).deliver_now
        format.html { redirect_to article_path(@request.article), notice: t(".request_send") }
        format.js { head :ok }

      else
        format.html { redirect_to article_path(@request.article), alert: t(".request_error") }

        format.js { head :unprocessible_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_article_request_params
      params.require(:user_article_request).permit(:text, :article_id, :with_phoneno, :with_email)
    end
end
