class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # # POST /resource/sign_in
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

  # # DELETE /resource/sign_out
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
end
