class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    #set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
  # def create
  #   super
  #   search = Search.new(session[:search])
  #   # load the first location into session address
  #   if current_user.locations.count > 0
  #     search.use_location = true
  #     search.location = current_user.locations.first
  #   end
  #   session[:search] = search
  # end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    #set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end
  # def destroy
  #   super
  #   # search = Search.new(session[:search])
  #   # search.use_location = false
  #   # search.location = nil
  #   # session[:search] = search
  #   session.delete :search
  #   prepare_search_session
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(user)
    # lead to guidepost on first sign up
    # if user.sign_in_count == 0
    #   user_guidepost_path
    # else
    #   super(user)
    # end
    edit_user_registration_path
  end
end
