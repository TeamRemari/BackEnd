class FootPrint < ApplicationRecord
	acts_as_paranoid
  	self.abstract_class = true

  	belongs_to :user

	validates :user_id, presence: true
	validates :to_user_id, presence: true
end
