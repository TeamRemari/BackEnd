class Message < ApplicationRecord
	acts_as_paranoid
  	self.abstract_class = true

  	belongs_to :chat_room
end
