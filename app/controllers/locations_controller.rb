class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index_owner, :new, :edit, :create, :update, :destroy]
  before_action :verify_user_is_owner, only: [:edit, :update, :destroy]

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

    @locations = @user.locations.order(created_at: :asc)
  end
  
  # GET /locations/1
  # GET /locations/1.json
  def show
    #location = Location.new(street_and_no: session[:address])
    #if location.geocode
    #  @current_location = location
    #end
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
        format.html { render :show, success: t('.create_success') }
        format.json { render :show, status: :created, location: @location }
        format.js { render 'create_success' }
      else
        handle_geocoding_error(@location)
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
        format.html { render :show, success: t('.update_success') }
        format.json { render :show, status: :ok, location: @location }
        format.js { render 'update_success' }
      else
        handle_geocoding_error(@location)
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
    @list_is_empty = current_user.locations.empty?
    respond_to do |format|
      format.html { redirect_to :index_owner, success: t('.destroy_success') }
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
      permitted = [ :street_and_no, :postcode, :city, :country, :latitude, :longitude ]
      if is_admin?
        permitted.push :house_id
      end
      params.require(:location).permit(permitted)
    end

    # use to verify the location really belongs to the current user
    # not sure if this works, depends devise ensures that current_user is really the user that logged in
    def verify_user_is_owner
      # user is already authenticated
      unless is_admin? || current_user.id == @location.user.id
        respond_to do |format|
          format.html { redirect_to edit_user_registration_path, danger: t('locations.warning_not_owner') }
          format.json { head :no_content }
        end
      end
    end

    def handle_geocoding_error(location)
      if location.errors[:latitude] or location.errors[:longitude] # could not be geocoded
        location.errors.clear
        location.errors.add(:base, t("locations.warning_location_not_geocoded"))
      end
    end
end
