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
    unless @search.save
      # handle could not geocode error (like locations)
      render 'new'
      return
    end
    session[:search_id] = @search.id

    if @search.use_location
      @current_location = @search.location
    else
      @current_location = Location.new({latitude: @search.latitude, longitude: @search.longitude})
    end

    # provide bounding box for the map (would be better if done on client side)
    @bound_n = Geocoder::Calculations.endpoint(@current_location, 0, @search.radius)
    @bound_s = Geocoder::Calculations.endpoint(@current_location, 180, @search.radius)
    @bound_e = Geocoder::Calculations.endpoint(@current_location, 90, @search.radius)
    @bound_w = Geocoder::Calculations.endpoint(@current_location, 270, @search.radius)

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

    # limit articles and locations
    @articles = @articles.limit(Search.articles_per_page).page(1)
    @locations = @locations.limit(Search.locations_per_page).page(1)
    
    # provide houses to be drawn by the map
    @houses = @locations.collect { |l| l.house }.uniq
    
    # determine if there is a house at given location
    @house_center
    houses_center = House.near(@current_location, 0.01)
    if houses_center.length > 0
      @house_center = houses_center.first
    end

    render 'show'
  end

  private
  def search_parameters
    params.require('search').permit(['pattern'], ['address'], ['radius'], ['use_location'], ['location_id'])
  end
end
