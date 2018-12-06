# coding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  protect_from_forgery with: :exception
  before_action :prepare_search_session
  before_action :set_locale

  def accept_cookies
    session[:cookies_accepted] = true
  end

  def prepare_search_session
    # resolve the origin of the request and store the location for later use
    if !session.has_key?(:address) || session[:address].empty?
      addr = Geocoder.address(request.remote_ip)
      if addr.empty? || addr == "Reserved" # got that for remote_ip localhost
        addr = "Dresden, Germany"
        addr = "Berlin, BE 13357, Germany"
      end
      if addr
        session[:address] = addr
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
