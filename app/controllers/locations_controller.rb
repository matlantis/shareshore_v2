class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :verify_user_is_owner, only: [:edit, :update, :destroy]

  # def index
  #   # admins can see articles of other users
  #   user = nil
  #   if params.key?(:user_id) && is_admin?
  #     user = User.find_by(id: params[:user_id].to_i)
  #   end
  #   if user
  #     @user = user
  #   else
  #     @user = current_user
  #   end

  #   @locations = @user.locations.order(created_at: :asc)

  #   # init new location and try to prefill country and city
  #   @location = Location.new
  #   if session.has_key?(:address)
  #     parts = session[:address].split(',')
  #     if parts.length > 0
  #       @location.city = parts[0].strip() # guess the first part is the city
        
  #       country_part = parts[-1].strip() # guess the last part is the country part
  #       country = ISO3166::Country.find_country_by_name(country_part)
  #       if country
  #         @location.country = country.alpha2
  #       end
  #     end
  #   end
  # end
  
  # GET /locations/1
  # GET /locations/1.json
  def show
    #location = Location.new(street_and_no: session[:address])
    #if location.geocode
    #  @current_location = location
    #end
    @articles = @location.articles.order(title: :asc)
  end

  # GET /locations/new
  def new
    @location = Location.new
    if session.has_key?(:address)
      parts = session[:address].split(',')
      if parts.length > 0
        @location.city = parts[0].strip() # guess the first part is the city
        
        country_part = parts[-1].strip() # guess the last part is the country part
        country = ISO3166::Country.find_country_by_name(country_part)
        if country
          @location.country = country.alpha2
        end
      end
    end
  end

  # GET /locations/1/edit
  def edit
  end

  # # POST /locations
  # # POST /locations.json
  # def create
  #   @location = Location.create(location_params)
  #   current_user.location = @location
  #   @location_div_id = "location_" + @location.id.to_s + "_div" # for js

  #   respond_to do |format|
  #     if @location.save
  #       format.html { redirect_to locations_path, notice: t('.create_success') }

  #       format.js { render 'create_success' }
  #     else
  #       handle_geocoding_error(@location)
  #       format.html { redirect_to locations_path, alert: t('.create_error') }

  #       format.js { render 'create_error' }
  #     end
  #   end
  # end

  # # PATCH/PUT /locations/1
  # # PATCH/PUT /locations/1.json
  # def update
  #   @location_div_id = "location_" + @location.id.to_s + "_div" # for js
  #   respond_to do |format|
  #     if @location.update(location_params)
  #       format.html { redirect_to locations_path, notice: t('.update_success') }
  #       format.json { render :show, status: :ok, location: @location }
  #       format.js { render 'update_success' }
  #     else
  #       handle_geocoding_error(@location)
  #       format.html { redirect_to locations_path, alert: t('.update_error') }
  #       format.json { render json: @location.errors, status: :unprocessable_entity }
  #       format.js { render 'update_error' }
  #     end
  #   end
  # end

  # # DELETE /locations/1
  # # DELETE /locations/1.json
  # def destroy
  #   user = @location.user
  #   @location.destroy
  #   @location_div_id = "location_" + @location.id.to_s + "_div" # for js
  #   @list_is_empty = user.locations.empty?
  #   respond_to do |format|
  #     format.html { redirect_to locations_path, notice: t('.destroy_success') }
  #     format.js {}

  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      permitted = [ :street, :number, :postcode, :city, :country, :latitude, :longitude ]
      if is_admin?
        permitted.push :house_id
      end
      params.require(:location).permit(permitted)
    end

    # use to verify the location really belongs to the current user
    # not sure if this works, depends devise ensures that current_user is really the user that logged in
    def verify_user_is_owner
      # admin is already authenticated
      unless is_admin? || current_user.id == @location.user.id
        respond_to do |format|
          format.html { redirect_to edit_user_registration_path, danger: t('locations.warning_not_owner') }

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
