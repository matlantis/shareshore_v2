class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  prepend_before_action :authenticate_scope!, only: [ :guidepost, :update_guidepost, :edit, :update, :destroy]

  def index
    authenticate_admin!
    @users = User.all.order(nickname: :asc)
    @users = @users.paginate(page: params[:page], per_page: 100)    
  end
  
  def show
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = t('.warning_user_not_existent')
      redirect_to "/"
    end

    @with_contact = user_signed_in? || verify_recaptcha
    # remove the recaptcha error msg
    flash.delete("recaptcha_error")
  end


  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    if params.key?("password") && !params["password"].empty?
      resource.update_with_password(params)
    else
      # delete password and current_password field
      params.delete("current_password")
      params.delete("password")
      params.delete("password_confirmation")
      resource.update(params)
    end
  end
  
  def guidepost
    @location = Location.new
  end

  def update_contact
    p = params.require(:user).permit(:firstname, :lastname, :showphone, :showemail, :showname, :phoneno)
    success = current_user.update(p)
    # this updates only the contactdetails not the basic informations
    respond_to do |format|
      format.html { render :edit }
    end
  end
  
  def update_guidepost
    if params.has_key? :user
      @location = Location.new # create a location for the form (maybe needed)
      
      p = params.require(:user).permit(:firstname, :lastname, :showphone, :showemail, :showname, :phoneno)
      success = current_user.update(p)
      # this updates only the locations not the basic informations
      respond_to do |format|
        if success
          flash[:success] = t('.update_contact_info_success')
        end
        format.html { render :guidepost }
        #format.html { redirect_to edit_user_locations_path }
      end
    elsif params.has_key? :location            
      p = params.require(:location).permit(:street, :number, :postcode, :city, :country)
      @location = current_user.locations.create(p)
      respond_to do |format|
        if @location.save
          flash[:success] = t('.create_location_success')
        else
          if @location.errors[:latitude] or @location.errors[:longitude] # could not be geocoded
            @location.errors.clear
            @location.errors.add(:base, t('.warning_location_not_geocoded'))
          end
        end
        format.html { render :guidepost }
      end
    end
    
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if !verify_recaptcha
      flash.delete :recaptcha_error
      build_resource(sign_up_params)
      resource.valid?
      resource.errors.add(:base, t('recaptcha.errors.verification_failed'))
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render :new }
    else
      flash.delete :recaptcha_error
      super
    end
  end

  # GET /resource/edit
  def edit
    @locations = @user.locations.order(created_at: :asc)

    # init new location and try to prefill country and city
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
    super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:nickname, :email, :password, :password_confirmation, :terms) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:nickname, :firstname, :lastname, :phoneno, :email, :password, :password_confirmation, :current_password, :showemail, :showphone, :showname, :aboutme) }
  end

  # The default url to be used after updating a resource. You need to overwrite
  def after_update_path_for(resource)
    edit_user_registration_path
  end


  def check_captcha
    unless verify_recaptcha
      flash.delete :recaptcha_error
      build_resource(sign_up_params)
      resource.valid?
      resource.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render :new }
      #self.resource = resource_class.new sign_up_params
      #respond_with_navigational(resource) { render :new }
    end 
  end

end
