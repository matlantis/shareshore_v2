# coding: utf-8
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update, :destroy, :new_from_stockitems ]
  before_action :authenticate_admin!, only: [:edit]
  before_action :verify_user_is_owner, only: [:edit, :update, :destroy]
  before_action :redirect_user_without_location, only: [:index, :new_from_stockitems]

  def redirect_user_without_location
    if current_user.locations.count < 1
      flash[:notice] = t('articles.redirected_to_create_location')
      redirect_to locations_path
    end
  end

  def edit
    @owner = @article.location.user
  end
  
  def index
    # admins can see articles of other users
    user = nil
    if params.key?(:user_id) && is_admin?
      user = User.find_by(id: params[:user_id].to_i)
    end
    if user
      @user = user
    else
      @user = current_user
    end
    
    @articles = @user.articles.order(location_id: :asc, title: :asc)
  end

  def index_location # unused
    @location = Location.find_by(id: params[:location_id])
    if @location
      @articles = @location.articles
    else
      flash[:alert] = t('.location_not_existent')
      redirect_to search_path
      return
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
      flash[:alert] = t('.user_not_existent')
      redirect_to search_path
      return
    end
    @articles = @articles.order(location_id: :asc, title: :asc)

    # paginate
    @articles = @articles.paginate(page: params[:page], per_page: 100)
    
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    # with recaptcha
    @with_contact = user_signed_in? || verify_recaptcha
    # remove the recaptcha error msg
    flash.delete("recaptcha_error")
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  def new_from_stockitems
    @categories = Category.all.order({"name_" + I18n.locale.to_s => :asc})
    #@rooms = Stockitem.all.collect {|t| t.room }.uniq.sort

    # criterion_hash = {}
    # criterion_hash["title_" + I18n.locale.to_s] = :asc
    # @articles = {}
    # if params.has_key? 'room'
    #   @articles[params['room']] = []
    #   stockitems = Stockitem.where("room = ?", params['room'])
    #   # oder according to language title
    #   stockitems = stockitems.order(criterion_hash)
    #   stockitems.each do |t|
    #     @articles[params['room']].push Article.new.fill_from_stockitem t
    #   end
    # else   
    #   @rooms.each do |room|
    #     @articles[room] = []
    #     stockitems = Stockitem.where("room = ?", room)
    #     # oder according to language title
    #     stockitems = stockitems.order(criterion_hash)
    #     stockitems.each do |t|
    #       @articles[room].push Article.new.fill_from_stockitem t
    #     end
    #   end
    # end

    # @articles['own'] = []
  end

  def create_from_index
    @article = current_user.articles.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to articles_path, notice: t('.create_success') }
        format.js { render 'create_success_index'}
          
      else
        format.html { redirect_to articles_path, alert: t('.create_error') }
        format.js { render 'create_error_index'}
      end
    end
  end

  def create_from_stockitems
    @article = current_user.articles.new(article_params)
    respond_to do |format|
      if @article.save        
        format.html { redirect_to user_new_article_from_stockitems_path, notice: t('.create_success') }
        format.js { render 'create_success_stockitems'}
          
      else
        format.html { redirect_to user_new_article_from_stockitems_path, alert: t('.create_error') }
        format.js { render 'create_error_stockitems'}
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
        format.html { redirect_to articles_path, notice: t('.update_success') }
        format.js { render 'update_success' }
      else
        format.html { redirect_to articles_path, alert: t('.update_error') }
        format.js { render 'update_error' }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    @article_div_id = "article_" + @article.id.to_s + "_div" # for js
    @list_is_empty = current_user.articles.empty?
    respond_to do |format|
      format.html { redirect_to articles_path, notice: t('.destroy_success') }
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
      params.require(:article).permit(:title, :details, :quality, :value_eur, :rate, :deposit_eur, :location_id, :picture, :gratis, :stockitem_id)
    end

    # use to verify the article really belongs to the current user
    # not sure if this works, depends devise ensures that current_user is really the user that logged in
    def verify_user_is_owner
      unless is_admin? || current_user.id == @article.user.id
        respond_to do |format|
          flash[:danger] = t('articles.warning_not_owner')
          format.html { redirect_to articles_url }
        end
      end
    end
end
