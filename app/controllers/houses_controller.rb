class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:index, :edit, :update]

  def index
    @houses = House.all
    @houses = @houses.paginate(page: params[:page], per_page: 100)
  end
  
  def show
    @articles = Article.includes(:location).where({locations: {house_id: @house.id}})
  end

  def edit
  end

  def update
    success = @house.update(house_params)
    redirect_to houses_path
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_params
      params.require(:house).permit(:street, :number, :postcode, :city, :country)
    end
end
