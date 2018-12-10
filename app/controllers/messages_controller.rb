class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:userreply]
  before_action :authenticate_user!, only: [ :create]

  def userreply
    # get sender and receiver from TO address
    uuid_match = /msg_([0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12})_([0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12})@userreply.shareship.de/.match(params['recipient'])
    if !uuid_match || uuid_match.length != 3
      # send error 406 if something went wrong to say "don't retry" to mailgun
      head :not_acceptable
      logger.info "bad TO address"
      return
    end

    receiver_public_uuid = uuid_match[1]
    sender_private_uuid = uuid_match[2]

    receiver = User.find_by(public_uuid: receiver_public_uuid)
    sender = User.find_by(private_uuid: sender_private_uuid)

    # compare senders email address
    unless sender and sender.email ==  params['sender']
      # send error 406 if something went wrong to say "don't retry" to mailgun
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
    @message = Message.new({text: params['body-plain'], html: params['body-html'], receiver_id: receiver.id, sender_id: sender.id, with_name: false, with_phoneno: false, with_email: false, subject: params['subject']})

    if @message.save
      UserMailer.user_message_mail(@message).deliver_now
      # render ok
      head :ok
    else
      head :not_acceptable
    end

  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user

    respond_to do |format|
      if @message.save
        UserMailer.user_message_mail(@message).deliver_now
        format.js { head :ok }
      else
        format.js { head :unprocessible_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:text, :html, :receiver_id)
    end
end
