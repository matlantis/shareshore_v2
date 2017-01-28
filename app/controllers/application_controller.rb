# coding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :prepare_search_session
  before_action :set_locale

  def accept_beta
    session[:beta_accepted] = true
  end
  
  def prepare_search_session
    unless session.key? :search # seems to be a new user
      addr = Geocoder.address(request.remote_ip)
      if addr == "Reserved" # got that for remote_ip localhost
        addr = "Dresden, Germany"
      end
      # if addr
      #   search = Search.new
      #   search.address = addr
      #   search.radius = 1.5
      #   session[:search] = search
      # end
    end    
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def authenticate_admin!
    authenticate_user!
    if current_user.role != 'admin'
      redirect_to("/", warning: 'forbidden', status: :forbidden)
    end
  end    

  def is_admin?
    user_signed_in? && current_user.role == "admin"
  end

  helper_method :is_admin?
end
