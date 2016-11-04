class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index_owner, :new, :edit, :create, :update, :destroy]
  before_action :verify_user_is_owner, only: [:edit, :update, :destroy]

  def index_owner
    @locations = current_user.locations.order(created_at: :asc)
  end
  
  # GET /locations
  # GET /locations.json
  def index
    # save the search parameters to the session
    session[:pattern] = params[:pattern] if params.key? :pattern
    session[:radius] = params[:radius] if params.key? :radius
    session[:address] = params[:address] if params.key? :address

    @locations = Location.all

    # remove own locations
    if current_user
      @locations = @locations.where.not(user: current_user)
    end

    # decode current location
    location = Location.new(street_and_no: session[:address])
    if location.geocode
      @current_location = location
    else
      flash[:alert] = 'Your location is unknown'
      redirect_to search_articles_path
    end
    
    # apply location criteria
    @locations = @locations.near(@current_location, session[:radius])     

    # provide bounding box for the map (would be better if done on client side)
    @bound_n = Geocoder::Calculations.endpoint(@current_location, 0, session[:radius])
    @bound_s = Geocoder::Calculations.endpoint(@current_location, 180, session[:radius])
    @bound_e = Geocoder::Calculations.endpoint(@current_location, 90, session[:radius])
    @bound_w = Geocoder::Calculations.endpoint(@current_location, 270, session[:radius])

    # paginate
    @locations = @locations.paginate(page: params[:page], per_page: 20)
  end

  def index_user
    @user = User.find_by(id: params[:user_id])
    if @user
      @locations = @user.locations
    else
      flash[:alert] = 'the user is unknown'        
      @locations = Location.all
    end
    @locations = @location.order(created_at: :asc)
  
    # paginate
    @locations = @locations.paginate(page: params[:page], per_page: 20)
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    location = Location.new(street_and_no: session[:address])
    if location.geocode
      @current_location = location
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    # commented because always create for the current_user
    # # can only create own locations
    # unless params[:user_id].to_i == current_user.id
    #   respond_to do |format|
    #     format.html { redirect_to locations_url, alert: 'Can only create own locations' }
    #     format.json { head :no_content }
    #   end
    #   return
    # end
    
    # user = User.find_by(id: params[:user_id])
    # # check if user exists
    # unless user
    #   respond_to do |format|
    #     format.html { redirect_to locations_url, alert: 'could not find user' }
    #     format.json { head :no_content }
    #   end
    #   return
    # end

    @location = current_user.locations.create(location_params)
    @location_div_id = "location_" + @location.id.to_s + "_div" # for js

    respond_to do |format|
      if @location.save
        format.html { redirect_to edit_user_locations_path, success: t('Location was successfully created') }
        format.json { render :show, status: :created, location: @location }
        format.js { render 'create_success' }
      else
        if @location.errors[:latitude] or @location.errors[:longitude] # could not be geocoded
          @location.errors.clear
          @location.errors.add(:base, t("address_unknown"))
        end
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
        format.js { render 'create_error' }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    @location_div_id = "location_" + @location.id.to_s + "_div" # for js
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to edit_user_registration_path, success: t('Location was successfully updated') }
        format.json { render :show, status: :ok, location: @location }
        format.js { render 'update_success' }
      else
        if @location.errors[:latitude] or @location.errors[:longitude] # could not be geocoded
          @location.errors.clear
          @location.errors.add(:base, t("address_unknown"))
        end
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
        format.js { render 'update_error' }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    @location_div_id = "location_" + @location.id.to_s + "_div" # for js
    respond_to do |format|
      format.html { redirect_to edit_user_locations_path, success: t('Location was successfully destroyed') }
      format.js {}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:street_and_no, :postcode, :city, :country)
    end

    # use to verify the location really belongs to the current user
    # not sure if this works, depends devise ensures that current_user is really the user that logged in
    def verify_user_is_owner
      # user is already authenticated
      if current_user.id != @location.user.id
        respond_to do |format|
          flash[:danger] = t('You are not owner of this location')
          format.html { redirect_to edit_user_registration_path }
          format.json { head :no_content }
        end
      end
    end
end
