class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
  #before_filter :configure_permitted_parameters

  before_action :configure_permitted_parameters, if: :devise_controller?

  prepend_before_action :authenticate_scope!, only: [:create_articles, :edit_guidepost, :update_guidepost, :edit_basic, :edit_locations, :edit_articles, :edit, :update_locations, :update_articles, :new_articles, :update, :destroy]

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = "Unknown User"
      redirect_to "/"
    end
  end
  
  def edit_locations
    @locations = current_user.locations

    #@locations.build
    #@locations = @locations.sort_by {|o| o.created_at.to_s }

    @locations = @locations.order("created_at ASC")
    @locations = @locations.paginate(:page => params[:page], per_page: 5)
    
    render :edit_locations
  end

  def edit_articles
    @articles = current_user.articles

    #@articles.build
    #@articles = @articles.sort_by {|o| o.created_at.to_s }

    @articles = @articles.order("created_at ASC")
    @articles = @articles.paginate(:page => params[:page], per_page: 10)

    render :edit_articles
  end

  def new_articles
    @rooms = Template.all.collect {|t| t.room }.uniq
    @articles = {}
    if params.has_key? 'room'
      @articles[params['room']] = []
      templates = Template.where("room = ?", params['room'])
      templates.each do |t|
        @articles[params['room']].push Article.new.fill_from_template t
      end
    else   
      @rooms.each do |room|
        @articles[room] = []
        templates = Template.where("room = ?", room)
        templates.each do |t|
          @articles[room].push Article.new.fill_from_template t
        end
      end
    end

    @articles['new'] = []
    a = Article.new({ rate_eur: 1, rate_interval: 'day', quality: 3})
    @articles['new'].push(a)
    
    
    render :new_articles
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
  def edit_basic
  end

  def edit_guidepost
    @location = Location.new
  end
  
  # PUT /resource
  def update_articles
    p = params.require(:user).permit(articles_attributes: [:title, :rate_eur, :value_eur, :rate_interval, :location_id, :id ])

    # this updates only the articles not the basic informations
    respond_to do |format|
      if current_user.update(p)
        flash[:success] = t('Articles were successfully updated')
      end
      format.html { redirect_to edit_user_articles_path }
    end
  end

  def create_articles
    p = params.require(:user).permit(articles_attributes: [:to_be_created, :title, :details, :quality, :rate_eur, :value_eur, :rate_interval, :location_id, :id, :template_id ])

    success = true
    p['articles_attributes'].each do |a|
      if a[1][:to_be_created] != "0"
        success = success and current_user.articles.create(a[1])
      end
    end

    if not success
      # rollback # TODO: 
    end
    
    # this updates only the articles not the basic informations
    respond_to do |format|
      if success
        flash[:success] = t('Articles were successfully updated')
        format.html { redirect_to new_user_articles_path }
      else
        format.html { render :new_user_articles }
      end
      
    end
  end

  def update_locations
    p = params.require(:user).permit(locations_attributes: [:street_and_no, :postcode, :city, :country, :id ])
    success = current_user.update(p)

    @locations = current_user.locations
    @locations = @locations.order("created_at ASC")
    @locations = @locations.paginate(:page => params[:page], per_page: 5)

    # this updates only the locations not the basic informations
    respond_to do |format|
      if success
        flash[:success] = t('Locations were successfully updated')
      end
      format.html { render :edit_locations }
      #format.html { redirect_to edit_user_locations_path }
    end
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update_basic
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: edit_user_basic_path
    else
      clean_up_passwords resource
      render :edit_basic
      #respond_with resource, location: edit_user_basic_path
    end
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
        format.html { render :edit_guidepost }
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
        format.html { render :edit_guidepost }
      end
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
  def after_sign_up_path_for(resource)
    edit_user_guidepost_path
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
