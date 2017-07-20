class PagesController < ApplicationController
  def show
    @title = t("titles.pages.#{params[:page]}")
    render template: "pages/#{params[:page]}"
  end
  
  def index
    last_search = nil
    if session.key? :search_id
      last_search = Search.find_by(id: session[:search_id])
    end
    if last_search
      @search = last_search.dup
    else
      @search = Search.new

      @search.use_location ||= !current_user.nil? && current_user.location
      # set the location
      if !current_user.nil? && current_user.location
        @search.location ||= current_user.location
      end

      # try to get address from session
      if session.has_key?(:address)
        @search.address = session[:address]
      end
    end
  end

  def admin
    authenticate_admin!
  end
end
