# coding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :prepare_current_session
  before_action :set_locale
  
  def prepare_current_session
    unless session.key? :address # seems to be a new user
      addr = Geocoder.address(request.remote_ip)
      if addr == "Reserved" # got that for remote_ip localhost
        addr = "Usedom, Germany"
      end
      if addr
        session[:address] = addr
      end
    end

    print "Adress: " + session[:address] + "!!"
    
    unless session.key? :radius
      session[:radius] = 5
    end
    
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
