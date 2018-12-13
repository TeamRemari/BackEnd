class Api::V1::FootPrintsController < Api::V1::ApplicationController

	before_action :authenticate, only: [:mine_to, :create, :mine_from]

  	protect_from_forgery :except => [:create]

  	def create
  		@foot_print = FootPrint.new()
  		@foot_print.user_id = @current_user.id
  		@foot_print.to_user_id = params[:to_user_id]
  		if @foot_print.save
  			render json: Api::V1::FootPrintSerializer.new(@foot_print)
  		else
  			render json: {
      						error: {
        						messages: @foot_print.errors.full_messages,
        						status: -1,
        					}
      					}
  		end
  	end

  	def mine_to
  		@foot_prints = FootPrint.where(user_id: @current_user.id)
  		render json: @foot_prints, each_serializer: FootPrintSerializer
  	end

  	def mine_from
  		@foot_prints = FootPrint.where(to_user_id: @current_user.id)
  		render json: @foot_prints, each_serializer: FootPrintSerializer
  	end
end