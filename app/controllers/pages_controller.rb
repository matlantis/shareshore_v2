class PagesController < ApplicationController
  def show
    render template: "pages/#{params[:page]}"
  end

  def contact
    @subject = ''
    if params.key? :subject
      @subject = params.delete(:subject)
    end
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
      @search.init(request, current_user)
    end
  end

  def admin
    authenticate_admin!
  end
end
