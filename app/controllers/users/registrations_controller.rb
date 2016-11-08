class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  before_action :configure_permitted_parameters, if: :devise_controller?

  prepend_before_action :authenticate_scope!, only: [ :guidepost, :update_guidepost, :edit, :update, :destroy]

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = "Unknown User"
      redirect_to "/"
    end
  end

  def guidepost
    @location = Location.new
  end

  def update_guidepost
    if params.has_key? :user
      @location = Location.new # create a location for the form (maybe needed)
      
      p = params.require(:user).permit(:firstname, :lastname, :showphone, :showemail, :phoneno)
      success = current_user.update(p)
      # this updates only the locations not the basic informations
      respond_to do |format|
        if success
          flash[:success] = t('Successfully updated contact info')
        end
        format.html { render :guidepost }
        #format.html { redirect_to edit_user_locations_path }
      end
    elsif params.has_key? :location            
      p = params.require(:location).permit(:street_and_no, :postcode, :city, :country)
      @location = current_user.locations.create(p)
      respond_to do |format|
        if @location.save
          flash[:success] = t('Location was successfully created')
        else
          if @location.errors[:latitude] or @location.errors[:longitude] # could not be geocoded
            @location.errors.clear
            @location.errors.add(:base, t("address_unknown"))
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
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

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

    # The path used after sign up.
  def after_sign_up_path_for(resource)
    user_guidepost_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:nickname, :firstname, :lastname, :phoneno, :email, :password, :password_confirmation, :showemail, :showphone) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:nickname, :firstname, :lastname, :phoneno, :email, :password, :password_confirmation, :current_password, :showemail, :showphone) }
  end

  # The default url to be used after updating a resource. You need to overwrite
  def after_update_path_for(resource)
    edit_user_registration_path
  end

end
