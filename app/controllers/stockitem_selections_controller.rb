class StockitemSelectionsController < ApplicationController
  before_action :set_stockitem_selection, only: [:show, :edit, :update, :destroy]

  prepend_before_action :authenticate_user!, only: [:create]

  # GET /stockitem_selections
  # GET /stockitem_selections.json
  def index
    @stockitem_selections = StockitemSelection.all
  end

  # GET /stockitem_selections/1
  # GET /stockitem_selections/1.json
  def show
  end

  # GET /stockitem_selections/new
  def new
    @stockitem_selection = StockitemSelection.new
    @rooms = Stockitem.all.collect {|t| t.room }.uniq.sort
    @stockitems = {}
    @rooms.each do |room|
      @stockitems[room] = Stockitem.where("room = ?", room).order(:title)
    end
  end

  # GET /stockitem_selections/1/edit
  def edit
  end

  # POST /stockitem_selections
  # POST /stockitem_selections.json
  def create
    # check if the user is logged in using devise helpers (available here?)
    # done by authenticate_user!

    # create the selection from parameters
    stockitem_selection = StockitemSelection.new(stockitem_selection_params)

    # create articles from the stockitem_selection
    @articles = []
    stockitem_selection.stockitems.each do |stockitem|
      @articles.push Article.new.fill_from_stockitem(stockitem)
    end
    
    # save articles to user
    
    # redirect to users articles

    # or maybe better: dont save the articles but lead to new_articles page with prefilled fields
  end

  # PATCH/PUT /stockitem_selections/1
  # PATCH/PUT /stockitem_selections/1.json
  def update
    respond_to do |format|
      if @stockitem_selection.update(stockitem_selection_params)
        format.html { redirect_to @stockitem_selection, notice: 'Stockitem selection was successfully updated.' }
        format.json { render :show, status: :ok, location: @stockitem_selection }
      else
        format.html { render :edit }
        format.json { render json: @stockitem_selection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stockitem_selections/1
  # DELETE /stockitem_selections/1.json
  def destroy
    @stockitem_selection.destroy
    respond_to do |format|
      format.html { redirect_to stockitem_selections_url, notice: 'Stockitem selection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stockitem_selection
      @stockitem_selection = StockitemSelection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stockitem_selection_params
      #params.fetch(:stockitem_selection, {})
      params.require(:stockitem_selection).permit(stockitem_ids: [])
    end
end
