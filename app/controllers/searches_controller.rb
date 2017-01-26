# coding: utf-8
class SearchesController < ApplicationController
  before_action :authenticate_user! # für beta phase
                       
  def new
    # if there are search parameters continue with create
    if params.key? :search
      create
      return
    end
    
    last_search = nil
    if session.key? :search_id
      last_search = Search.find_by(id: session[:search_id])
    end
    if last_search
      @search = last_search.dup
    else
      @search = Search.new
      @search.init(request, current_user)
    end
  end

  def create
    @search = Search.new(search_parameters)
    # if coming from map, dont save the search
    if params[:commit] != 'Map'
      unless @search.save
        # handle could not geocode error (like locations)
        render 'new'
        return
      end
      session[:search_id] = @search.id
    else
      unless @search.valid?
        # handle could not geocode error (like locations)
        render 'new'
        return
      end
    end

    if @search.use_location
      @current_location = @search.location
    else
      @current_location = Location.new({latitude: @search.latitude, longitude: @search.longitude})
    end

    # if address is not given (coming from map), write coords into address field
    # for view and subsequent submit
    if not @search.address and not @search.use_location
      @search.address = "[" + @search.latitude.to_s + "," + @search.longitude.to_s + "]"
    end

    
    # provide bounding box for the map (would be better if done on client side)
    # if comming from map to it differently
    if params[:commit] != 'Map'
      @bounds = [ Geocoder::Calculations.endpoint(@current_location, 0, @search.radius),
                  Geocoder::Calculations.endpoint(@current_location, 180, @search.radius),
                  Geocoder::Calculations.endpoint(@current_location, 90, @search.radius),
                  Geocoder::Calculations.endpoint(@current_location, 270, @search.radius) ]
    else
      @bounds = [ Geocoder::Calculations.endpoint(@current_location, 45, @search.radius/4),
                  Geocoder::Calculations.endpoint(@current_location, 225, @search.radius/4) ]
    end

    @articles = Article.all
    # remove own articles
    if current_user
      @articles = @articles.where.not(user: current_user)
    end
    # apply location criteria
    @articles = @articles.joins(:location).near(@current_location, @search.radius)     
    @articles = @articles.order(title: :asc) # 2nd criterion after location
    # apply pattern criteria
    unless @search.pattern.empty?
      @articles = @articles.search(@search.pattern) # no sorting is done here
    end
    # paginate
    #@articles = @articles.paginate(page: params[:page], per_page: 5)

    # locations
    @locations = Location.where(id: @articles.map {|a| a.location_id})
    @locations = @locations.near(@current_location, @search.radius) # resort

    # limit articles and locations
    @articles = @articles.limit(Search.articles_per_page).page(1)
    @locations = @locations.limit(Search.locations_per_page).page(1)
    
    # build an location_articles_list
    @location_articles_list = @locations.map { |l|
      local_articles = @articles.where(location_id: l.id)
      {location: l, articles: local_articles }
    }
    
    # provide houses to be drawn by the map
    @houses = @locations.collect { |l| l.house }.uniq
    
    # determine if there is a house at given location
    @house_center
    houses_center = House.near(@current_location, 0.01)
    if houses_center.length > 0
      @house_center = houses_center.first
    end

    respond_to do |format|
      format.html { render 'show' }
      format.js { render 'show' }
    end
  end

  private
  def search_parameters
    params.require(:search).permit(:pattern, :address, :radius, :use_location, :location_id, :longitude, :latitude)
  end
end
