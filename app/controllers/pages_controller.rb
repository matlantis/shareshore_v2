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
  end
end
