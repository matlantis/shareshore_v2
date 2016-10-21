class PagesController < ApplicationController
  def show
    render stockitem: "pages/#{params[:page]}"
  end

  def index
  end
end
