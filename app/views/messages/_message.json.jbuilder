json.extract! message, :id, :text, :sender_id, :receiver_id, :with_name, :with_phoneno, :with_email, :created_at, :updated_at
json.url message_url(message, format: :json)