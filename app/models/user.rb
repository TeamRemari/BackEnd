class User < ApplicationRecord
	acts_as_paranoid
  	self.abstract_class = true

  	has_one  :facebook_auth, dependent: :destroy
  	has_many :blocks, dependent: :destroy
  	has_many :reports

  	before_create :assign_authentication_token

  	def assign_authentication_token
		self.authentication_token = generate_authentication_token
	end

	# Generate a unique API key
	def generate_authentication_token
		loop do
			token = SecureRandom.base64.tr('+/=', 'Qrt')
			break token unless User.exists?(authentication_token: token)
		end
	end

	def is_blocking_user(user_id)
  		@blocks = self.blocks.where(blockable_type: "User")
  		@blocks.find_by(blockable_id: user_id).present?
  	end

  	def is_blocked_from_user(user_id)
  		@user = User.find(user_id)
  		@blocks = @user.blocks.where(blockable_type: "User")
  		@blocks.find_by(blockable_id: self.id).present?
  	end

  	def is_blocking_relation(user_id)
  		self.is_blocking_user(user_id) || self.is_blocked_from_user(user_id)
  	end

  	def block_relation_user_ids
  		@blocked = Block.where(blockable_type: "User").where(blockable_id: self.id)
  		@blocking_relation_ids = Array.new()
  		if @blocked.present?
  			@blocked_ids = @blocked.pluck(:user_id) 
  			@blocking_relation_ids += @blocked_ids
  		end
  		@blocking = self.blocks.where(blockable_type: "User")
  		if @blocking.present?
  			@blocking_ids = @blocking.pluck(:blockable_id)
  			@blocking_relation_ids += @blocking_ids
  		end
  		@blocking_relation_ids
  	end

  	def users_ignore_block_relation
  		if block_relation_user_ids().empty?
  			User.all
  		else
  			@all_user_ids = User.all.pluck(:id)
  			@users_ignore_block_relation_ids = @all_user_ids - @blocking_relation_ids
  			User.where("id IN (?)", @users_ignore_block_relation_ids)
  		end
  	end
end
