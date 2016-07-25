class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :verify_user_is_owner, only: [:edit, :update, :destroy]
  before_action :verify_user_is_owner_of_location, only: [:create, :update]

  # the search
  def search
  end
  
  # GET /articles
  # GET /articles.json
  def index
    # save the search parameters to the session
    session[:pattern] = params[:pattern] if params.key? :pattern
    session[:radius] = params[:radius] if params.key? :radius
    session[:address] = params[:address] if params.key? :address

    if params.key? :location_id # apply location
      @location = Location.find_by(id: params[:location_id])
      if @location
        @articles = @location.articles
      else
        flash[:alert] = 'the location is unknown'        
        @articles = Article.all
      end
    elsif params.key? :user_id # apply owner
        # @articles = Article.where("articles.user_id = ?", params[:owner])
      @user = User.find_by(id: params[:user_id])
      if @user
        @articles = @user.articles
      else
        flash[:alert] = 'the user is unknown'        
        @articles = Article.all
      end
    else
      @articles = Article.all

      # apply location criteria
      location = Location.new(street_and_no: session[:address])
      if location.geocode
        @articles = @articles.joins(:location).near(location, session[:radius])     
      else
        flash[:alert] = 'Your location is unknown'
      end
    end

    # apply pattern criteria
    if session[:pattern]
      @articles = @articles.search(session[:pattern]).order("created_at DESC")
    else
      @articles = @articles.order('created_at DESC')
    end

  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    # commented because always create for the current_user
    # # can only create own articles
    # unless params[:user_id].to_i == current_user.id
    #   respond_to do |format|
    #     format.html { redirect_to articles_url, alert: 'Can only create own articles' }
    #     format.json { head :no_content }
    #   end
    #   return
    # end
    
    # # check if user exists
    # user = User.find_by(id: params[:user_id])
    # unless user
    #   respond_to do |format|
    #     format.html { redirect_to articles_url, alert: 'could not find user' }
    #     format.json { head :no_content }
    #   end
    #   return
    # end
    
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update    
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :details, :price_eur, :rate, :gratis, :deposit_eur, :location_id, :picture)
    end

    # use to verify the article really belongs to the current user
    # not sure if this works, depends devise ensures that current_user is really the user that logged in
    def verify_user_is_owner
      if current_user.id != @article.user.id
        respond_to do |format|
          format.html { redirect_to articles_url, alert: 'You are not owner of this article' }
          format.json { head :no_content }
        end
      end
    end

    def verify_user_is_owner_of_location
      user = current_user
    
      # check if location belongs to the user
      unless user.locations.exists?(article_params[:location_id])
        respond_to do |format|
          format.html { redirect_to articles_url, alert: 'location does not belong to the user' }
          format.json { head :no_content }
        end
        return
      end
    end
end
