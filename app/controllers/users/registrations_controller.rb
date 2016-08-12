class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
  #before_filter :configure_permitted_parameters

  before_action :configure_permitted_parameters, if: :devise_controller?

  prepend_before_action :authenticate_scope!, only: [:edit_locations, :edit_articles, :edit, :update_locations, :update_articles, :update, :destroy]

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = "Unknown User"
      redirect_to "/"
    end
  end
  
  def edit_locations
    render :edit_locations
  end

  def edit_articles
    render :edit_articles
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
  def update_articles
    p = params.require(:user).permit(articles_attributes: [:title, :rate_eur, :rate_interval, :location_id, :id ])

    # this updates only the articles not the basic informations
    respond_to do |format|
      if current_user.update(p)
        flash[:success] = t('Articles were successfully updated')
      end
      format.html { render :edit_articles }
    end
  end

  def update_locations
    p = params.require(:user).permit(locations_attributes: [:street_and_no, :postcode, :city, :country, :id ])

    # this updates only the locations not the basic informations
    respond_to do |format|
      if current_user.update(p)
        flash[:success] = t('Locations were successfully updated')
      end
      format.html { render :edit_locations }
    end
  end

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
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:nickname, :firstname, :lastname, :phoneno, :email, :password, :password_confirmation, :showemail, :showphone) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:nickname, :firstname, :lastname, :phoneno, :email, :password, :password_confirmation, :current_password, :showemail, :showphone) }
  end

  # The default url to be used after updating a resource. You need to overwrite
  def after_update_path_for(resource)
    edit_user_registration_path
  end

end
