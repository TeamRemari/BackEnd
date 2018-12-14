class ChatRoom < ApplicationRecord
	acts_as_paranoid
  	self.abstract_class = true

  	belongs_to :user
  	has_many :messages, dependent: :destroy
end
