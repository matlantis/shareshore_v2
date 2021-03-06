class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :html, :js, :json

  prepend_before_action :authenticate_scope!, only: [:index, :edit, :update, :destroy, :show]

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = t('.warning_user_not_existent')
      redirect_to "/"
    end

    @with_contact = user_signed_in? || verify_recaptcha
    # remove the recaptcha error msg
    flash.delete("recaptcha_error")

    @location_articles_list = [{location: @user.location, articles: @user.location.articles }]
    @articles = @user.articles
    @locations = [@user.location]

  end


  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    aboutme_need_review = params.key?(:aboutme) && (not params[:aboutme].empty?) && (params[:aboutme] != resource.aboutme)

    if params.key?("password") && !params["password"].empty?
      res = resource.update_with_password(params)
    else
      # delete password and current_password field
      params.delete("current_password")
      params.delete("password")
      params.delete("password_confirmation")
      # check if review is needed

      res = resource.update(params)
    end

    # handle geocoding error
    if resource.errors.has_key?(:"location.latitude") or resource.errors.has_key?(:"location.longitude") # could not be geocoded
      resource.errors.delete(:"location.latitude")
      resource.errors.delete(:"location.longitude")
      #resource.errors.add(:location, :invalid, message: t("locations.warning_location_not_geocoded"))
      resource.errors.add(:location, :not_geocoded)
    end

    if res
      # send admin review notification
      if aboutme_need_review
        content = "Aboutme: " + resource.aboutme
        UserMailer.admin_content_review_notification_mail(content, edit_registration_url(resource)).deliver_now
      end
      res
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
      params["user"]["location_attributes"] = { address: "San Sebastian de la Gomera" }
      super
    end
  end

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
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:nickname, :email, :password, :password_confirmation, :terms, location_attributes: [ :address],) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:nickname, :email, :password, :password_confirmation, :current_password, :showemail, :aboutme, :contact, location_attributes: [ :id, :address, :latitude, :longitude ]) }
  end

  # The default url to be used after updating a resource. You need to overwrite
  def after_update_path_for(resource)
    edit_user_registration_path
  end


  # nowhere used?
  def check_captcha
    unless verify_recaptcha
      flash.delete :recaptcha_error
      build_resource(sign_up_params)
      resource.valid?
      resource.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render :new }
    end
  end

end
