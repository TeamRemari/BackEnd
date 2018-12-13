class FacebookAuth < ApplicationRecord
	acts_as_paranoid
  	self.abstract_class = true

  	belongs_to :user, optional: true
end
