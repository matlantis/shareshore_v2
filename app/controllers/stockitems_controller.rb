class StockitemsController < ApplicationController
  before_action :set_stockitem, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  
  # GET /stockitems
  # GET /stockitems.json
  def index
    @rooms = Stockitem.all.collect {|t| t.room }.uniq
    if params.has_key? 'room'
      @stockitems = Stockitem.where("room = ?", params['room'])
    else
      @stockitems = Stockitem.all
    end

    @articles = []
    @stockitems.each do |t|
      a = Article.new(title: t.title, details: t.details_hint, rate: t.rate, picture: t.picture, stockitem_id: t.id, quality: 3)
      @articles.push(a)
    end
  end
  # GET /stockitems/1
  # GET /stockitems/1.json
  def show
  end

  # GET /stockitems/new
  def new
    if params.key? 'stockitem'
      @stockitem = Stockitem.new(stockitem_params)
    else
      @stockitem = Stockitem.new
    end
  end

  # GET /stockitems/1/edit
  def edit
  end

  # POST /stockitems
  # POST /stockitems.json
  def create
    @stockitem = Stockitem.new(stockitem_params)

    respond_to do |format|
      if @stockitem.save
        format.html { redirect_to @stockitem, notice: 'Stockitem was successfully created.' }
        format.json { render :show, status: :created, location: @stockitem }
      else
        format.html { render :new }
        format.json { render json: @stockitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stockitems/1
  # PATCH/PUT /stockitems/1.json
  def update
    respond_to do |format|
      if @stockitem.update(stockitem_params)
        format.html { redirect_to @stockitem, notice: 'Stockitem was successfully updated.' }
        format.json { render :show, status: :ok, location: @stockitem }
      else
        format.html { render :edit }
        format.json { render json: @stockitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stockitems/1
  # DELETE /stockitems/1.json
  def destroy
    @stockitem.destroy
    respond_to do |format|
      format.html { redirect_to stockitems_url, notice: 'Stockitem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stockitem
      @stockitem = Stockitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stockitem_params
      params.require(:stockitem).permit(:title, :details_hint, :rate, :picture, :room)
    end

    def authenticate_admin!
      authenticate_user!
      if current_user.role != 'admin'
        redirect_to("/", warning: 'forbidden', status: :forbidden)
      end
    end
end
