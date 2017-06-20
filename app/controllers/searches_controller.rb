# coding: utf-8
class SearchesController < ApplicationController
  before_action :authenticate_user! # für beta phase
                       
  def new
    # if there are search parameters continue with create
    if params.key? :search
      create
      return
    # uncomment to draw results via js after page load
    # elsif params.key? :mapupdate
    #   update
    #   return
    end
    
    last_search = nil
    if session.key? :search_id
      last_search = Search.find_by(id: session[:search_id])
    end
    if last_search
      @search = last_search.dup
    else
      @search = Search.new
      
      @search.use_location ||= !current_user.nil? && current_user.locations.count > 0
      # set the location
      if !current_user.nil? && current_user.locations.count > 0
        @search.location ||= current_user.locations.first
      end

      # try to get address from session
      if session.has_key?(:address)
        @search.address = session[:address]
      end
    end
  end

  def create
    @search = Search.new(search_parameters)
    # if coming from map, dont save the search
    unless @search.save
      # handle could not geocode error (like locations)
      handle_geocoding_error(@search)
      render 'new'
      return
    end
    session[:search_id] = @search.id

    if @search.use_location
      @current_location = @search.location
    else
      @current_location = Location.new({latitude: @search.latitude, longitude: @search.longitude})
    end

    #radius = Search.default_radius
    #radius = @search.radius
    bound_distance = SearchesHelper::TransportModel.radius(@search.transport)/3
    # provide bounding box for the map (would be better if done on client side)
    @bounds = [ Geocoder::Calculations.endpoint(@current_location, 0, bound_distance),
                Geocoder::Calculations.endpoint(@current_location, 180, bound_distance),
                Geocoder::Calculations.endpoint(@current_location, 90, bound_distance),
                Geocoder::Calculations.endpoint(@current_location, 270, bound_distance) ]

    # disable to draw results via js after page load (no articles need in this step)
    if true 
      @articles = Article.all

      # remove own articles
      if current_user
        @articles = @articles.includes(:location).where.not(locations: {user: current_user})
      end

      # apply location criteria
      @articles = @articles.joins(:location)
      @articles = @articles.near(@current_location, SearchesHelper::TransportModel.radius(@search.transport))
      @articles = @articles.order(title: :asc) # 2nd criterion after location

      # apply pattern criteria
      unless @search.pattern.empty?
        @articles = @articles.search(@search.pattern) # no sorting is done here
      end
      # paginate
      #@articles = @articles.paginate(page: params[:page], per_page: 5)

      # locations
      @locations = Location.where(id: @articles.map {|a| a.location_id})

      # this is unneccesarry (no its not, please understand re-sort as re-sort!)
      @locations = @locations.near(@current_location, SearchesHelper::TransportModel.radius(@search.transport)) # re-sort

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
    end
    
    # determine if there is a house at given location
    houses_center = House.near(@current_location, 0.01)
    if houses_center.length > 0
      @house_center = houses_center.first
    end

    respond_to do |format|
      format.html { render 'show' }
    end
  end
  
  # not used
  # draw results via js after page load or on map change
  def update 
    # find last search
    @search = Search.find_by(id: session[:search_id])
    unless @search
      render :head, :unprocessible_entity
    end

    if @search.use_location
      @current_location = @search.location
    else
      @current_location = Location.new({latitude: @search.latitude, longitude: @search.longitude})
    end
    
    bbox = [ params[:se_lat], params[:nw_lng], params[:nw_lat], params[:se_lng] ]

    @articles = Article.all
    # remove own articles
    if current_user
      @articles = @articles.includes(:location).where.not(locations: {user: current_user})
    end

    # apply location criteria
    @articles = @articles.joins(:location)
    @articles = @articles.within_bounding_box(bbox)
    @articles = @articles.order(title: :asc) # 2nd criterion after location

    # apply pattern criteria
    unless @search.pattern.empty?
      @articles = @articles.search(@search.pattern) # no sorting is done here
    end
    # paginate
    #@articles = @articles.paginate(page: params[:page], per_page: 5)

    # locations
    @locations = Location.where(id: @articles.map {|a| a.location_id})

    # this is unneccesarry
    #@locations = @locations.within_bounding_box(bbox)

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
    houses_center = House.near(@current_location, 0.01)
    if houses_center.length > 0
      @house_center = houses_center.first
    end

    respond_to do |format|
      format.js { render 'show' }
    end
  end

  private
  def search_parameters
    params.require(:search).permit(:pattern, :address, :transport, :use_location, :location_id, :longitude, :latitude)
  end

    def handle_geocoding_error(search)
      if search.errors[:latitude] or search.errors[:longitude] # could not be geocoded
        search.errors.clear
        search.errors.add(:address, t("locations.warning_location_not_geocoded"))
        print "ttttttttttttttttttttttttttttttttttttttttttttt"
      end
    end

end
