class Report < ApplicationRecord
	acts_as_paranoid
  	self.abstract_class = true
  	
	belongs_to :reportable, polymorphic: true
	belongs_to :user, optional: true

	validates :user_id, presence: true
	validates :reportable_id, presence: true
end
