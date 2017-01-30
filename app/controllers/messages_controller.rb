class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:userreply]
  
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_admin!, only: [:index]
  before_action :authenticate_user!, only: [:show, :new, :create]
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # # GET /messages/1/edit
  # def edit
  # end
  def userreply
    # get sender and receiver from TO address
    uuid_match = /msg_([0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12})_([0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12})@userreply.shareship.de/.match(params['recipient'])
    
    receiver_public_uuid = uuid_match[1]
    sender_private_uuid = uuid_match[2]
    
    receiver = User.find_by(public_uuid: receiver_public_uuid)
    sender = User.find_by(private_uuid: sender_private_uuid)

    # compare senders email address
    unless sender and sender.email ==  params['sender']
      # send error 406 if something went to say "don't retry" to mailgun
      head :not_acceptable
      logger.info "sender not accepted"
      return
    end

    unless receiver
      head :not_acceptable
      logger.info "receiver not accepted"
      return
    end
    
    # create a message object and store it
    @message = Message.new({text: params['body-plain'], receiver_id: receiver.id, sender_id: sender.id, with_name: false, with_phoneno: false, with_email: false})

    if @message.save
      # call UserMailer user_message_mail
      UserMailer.user_message_mail(@message).deliver_now
      # render ok
      head :ok
    else
      head :not_acceptable
    end
      
  end
  
  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    
    respond_to do |format|
      if @message.save
        UserMailer.user_message_mail(@message).deliver_now
        format.html { redirect_to @message.receiver, notice: '.message_send' }
        format.js { head :ok }
      else
        format.html { redirect_to @message.receiver, notice: '.message_error' }
        format.js { head :unprocessible_entity }
      end
    end
  end

  # # PATCH/PUT /messages/1
  # # PATCH/PUT /messages/1.json
  # def update
  #   respond_to do |format|
  #     if @message.update(message_params)
  #       format.html { redirect_to @message, notice: 'Message was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @message }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @message.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /messages/1
  # # DELETE /messages/1.json
  # def destroy
  #   @message.destroy
  #   respond_to do |format|
  #     format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:text, :receiver_id, :with_name, :with_phoneno, :with_email)
    end
end
