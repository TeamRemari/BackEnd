class Block < ApplicationRecord
	acts_as_paranoid
  	self.abstract_class = true

  	belongs_to :blockable, polymorphic: true
	belongs_to :user, optional: true

	validates :user_id, presence: true
	validates :blockable_id, presence: true
end
