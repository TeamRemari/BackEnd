class FootPrint < ApplicationRecord
	acts_as_paranoid
  	self.abstract_class = true
end
