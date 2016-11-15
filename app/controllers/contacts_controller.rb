class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    if params.key? :subject
      @contact.subject = params.delete(:subject)
    end

    if current_user
      @contact.name = current_user.nickname
      @contact.email = current_user.email
    end
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.request = request
    if @contact.deliver
      flash.now[:success] = t('.thanks')
    else
      flash.now[:alert] = t('.cannot_send_message')
      render :new
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :message, :nickname, :subject)
  end
end
