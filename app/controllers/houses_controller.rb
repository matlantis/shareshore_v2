class HousesController < ApplicationController
  def show
    @house = House.find(params[:id])
    @articles = Article.includes(:location).where({locations: {house_id: @house.id}})
  end
end
