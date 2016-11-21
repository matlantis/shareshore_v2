class UserArticleRequestsController < ApplicationController
  before_action :set_user_article_request, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:index]
  before_action :authenticate_user!, only: [:show, :new, :create]

  # GET /user_article_requests
  # GET /user_article_requests.json
  def index
    @user_article_requests = UserArticleRequest.all
  end

  # GET /user_article_requests/1
  # GET /user_article_requests/1.json
  def show
  end

  # GET /user_article_requests/new
  def new
    @user_article_request = UserArticleRequest.new
  end

  # # GET /user_article_requests/1/edit
  # def edit
  # end

  # POST /user_article_requests
  # POST /user_article_requests.json
  def create
    @user_article_request = UserArticleRequest.new(user_article_request_params)
    @user_article_request.sender = current_user

    respond_to do |format|
      if @user_article_request.save
        format.html { redirect_to @user_article_request, notice: 'User article request was successfully created.' }
        format.json { render :show, status: :created, location: @user_article_request }
        format.js { head :ok }
        
      else
        format.html { render :new }
        format.json { render json: @user_article_request.errors, status: :unprocessable_entity }
        format.js { head :unprocessible_entity }
      end
    end
  end

  # # PATCH/PUT /user_article_requests/1
  # # PATCH/PUT /user_article_requests/1.json
  # def update
  #   respond_to do |format|
  #     if @user_article_request.update(user_article_request_params)
  #       format.html { redirect_to @user_article_request, notice: 'User article request was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user_article_request }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @user_article_request.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /user_article_requests/1
  # # DELETE /user_article_requests/1.json
  # def destroy
  #   @user_article_request.destroy
  #   respond_to do |format|
  #     format.html { redirect_to user_article_requests_url, notice: 'User article request was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_article_request
      @user_article_request = UserArticleRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_article_request_params
      params.require(:user_article_request).permit(:text, :receiver_id, :article_id)
    end
end
