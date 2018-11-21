class UserArticleRequestsController < ApplicationController
  before_action :set_user_article_request, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:index]
  before_action :authenticate_user!, only: [:show, :new, :create]

  # GET /user_article_requests
  # GET /user_article_requests.json
  def index
    @requests = UserArticleRequest.all
  end

  # GET /user_article_requests/1
  # GET /user_article_requests/1.json
  def show
  end

  # GET /user_article_requests/new
  def new
    @request = UserArticleRequest.new
  end

  # # GET /user_article_requests/1/edit
  # def edit
  # end

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

  # # PATCH/PUT /user_article_requests/1
  # # PATCH/PUT /user_article_requests/1.json
  # def update
  #   respond_to do |format|
  #     if @request.update(user_article_request_params)
  #       format.html { redirect_to @request, notice: 'User article request was successfully updated.' }

  #     else
  #       format.html { render :edit }

  #     end
  #   end
  # end

  # # DELETE /user_article_requests/1
  # # DELETE /user_article_requests/1.json
  # def destroy
  #   @request.destroy
  #   respond_to do |format|
  #     format.html { redirect_to user_article_requests_url, notice: 'User article request was successfully destroyed.' }

  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_article_request
      @request = UserArticleRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_article_request_params
      params.require(:user_article_request).permit(:text, :article_id, :with_phoneno, :with_email)
    end
end
