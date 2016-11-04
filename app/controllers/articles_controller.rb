# coding: utf-8
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :new_from_stockitems ]
  before_action :verify_user_is_owner, only: [:edit, :update, :destroy]
  before_action :verify_user_is_owner_of_location, only: [:create, :update]

  # the search
  def search
  end

  def index_owner
    @articles = current_user.articles.order(location_id: :asc, title: :asc)
  end
  
  # GET /articles
  # GET /articles.json
  def index
    # save the search parameters to the session
    session[:pattern] = params[:pattern] if params.key? :pattern
    session[:radius] = params[:radius] if params.key? :radius
    session[:address] = params[:address] if params.key? :address

    @articles = Article.all

    # remove own articles
    if current_user
      @articles = @articles.where.not(user: current_user)
    end
    
    # apply location criteria
    @current_location = Location.new(street_and_no: session[:address])
    if @current_location.geocode
      @articles = @articles.joins(:location).near(@current_location, session[:radius])     
    else
      flash[:alert] = 'Your location is unknown'
    end

    @articles = @articles.order(title: :asc) # 2nd criterion after location

    # provide bounding box for the map (would be better if done on client side)
    @bound_n = Geocoder::Calculations.endpoint(@current_location, 0, session[:radius])
    @bound_s = Geocoder::Calculations.endpoint(@current_location, 180, session[:radius])
    @bound_e = Geocoder::Calculations.endpoint(@current_location, 90, session[:radius])
    @bound_w = Geocoder::Calculations.endpoint(@current_location, 270, session[:radius])

    # apply pattern criteria
    if session[:pattern]
      @articles = @articles.search(session[:pattern]) # no sorting is done here
    end

    # provide locations to be drawn by the map
    @locations = @articles.collect { |a| a.location}.uniq

    # paginate
    @articles = @articles.paginate(page: params[:page], per_page: 100)
  end

  def index_location
    @location = Location.find_by(id: params[:location_id])
    if @location
      @articles = @location.articles
    else
      flash[:alert] = 'the location is unknown'        
      @articles = Article.all
    end
    @articles = @articles.order(title: :asc)

    # paginate
    @articles = @articles.paginate(page: params[:page], per_page: 100)    
  end

  def index_user # unused
    @user = User.find_by(id: params[:user_id])
    if @user
      @articles = @user.articles
    else
      flash[:alert] = 'the user is unknown'        
      @articles = Article.all
    end
    @articles = @articles.order(location_id: :asc, title: :asc)

    # paginate
    @articles = @articles.paginate(page: params[:page], per_page: 100)
    
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  def new_from_stockitems
    @rooms = Stockitem.all.collect {|t| t.room }.uniq.sort
    @articles = {}
    if params.has_key? 'room'
      @articles[params['room']] = []
      stockitems = Stockitem.where("room = ?", params['room']).order("title: :asc")
      stockitems.each do |t|
        @articles[params['room']].push Article.new.fill_from_stockitem t
      end
    else   
      @rooms.each do |room|
        @articles[room] = []
        stockitems = Stockitem.where("room = ?", room).order(title: :asc)
        stockitems.each do |t|
          @articles[room].push Article.new.fill_from_stockitem t
        end
      end
    end

    @articles['own'] = []
    # a = Article.new({ rate: '1€/tag', quality: 3})
    # @articles['new'].push(a)    
  end

  # GET /articles/1/edit
  def edit
    session[:return_to] ||= request.referer
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, success: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
        format.js { render 'create_success'}
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
        format.js { render 'create_error'}
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article_div_id = "article_" + @article.id.to_s + "_div" # for js
    success = @article.update(article_params)
    respond_to do |format|
      if success
        format.html {redirect_to session.delete(:return_to), success: t('Article was successfully updated') }
        format.js { render 'update_success' }
      else
        format.html { render :edit }
        format.js { render 'update_error' }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article_div_id = "article_" + @article.id.to_s + "_div" # for js

    @article.destroy
    respond_to do |format|
      format.html { redirect_to edit_user_articles_path, success: t('Article was successfully destroyed') }
      format.js {}
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
      params.require(:article).permit(:title, :details, :quality, :value_eur, :rate, :deposit_eur, :location_id, :picture, :gratis, :stockitem_id)
    end

    # use to verify the article really belongs to the current user
    # not sure if this works, depends devise ensures that current_user is really the user that logged in
    def verify_user_is_owner
      if current_user.id != @article.user.id
        respond_to do |format|
          flash[:danger] = t('You are not owner of this article')
          format.html { redirect_to articles_url }
          format.json { head :no_content }
        end
      end
    end

    def verify_user_is_owner_of_location
      user = current_user
    
      # check if location belongs to the user
      unless user.locations.exists?(article_params[:location_id])
        respond_to do |format|
          flash[:danger] = t('location does not belong to the user')
          format.html { redirect_to articles_url }
          format.json { head :no_content }
        end
        return
      end
    end
end
