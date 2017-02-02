class Message < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  after_initialize :init

  def init
    self.with_email ||= false 
    self.with_phoneno ||= false 
    self.with_name ||= false 
  end
end
