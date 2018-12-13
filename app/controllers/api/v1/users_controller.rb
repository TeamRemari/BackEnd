class Api::V1::UsersController < Api::V1::ApplicationController

	before_action :authenticate, only: [:index, :show, :delete, :favorite, :report, :block, :search, :update_last_login]

  	protect_from_forgery :except => [:sign_up, :sign_in]

  	def index
  		@users = @current_user.users_ignore_block_relation()
  		.page(params[:page])
  		.per(params[:limit])
  		.order(updated_at: :desc)
  		render json: @users, each_serializer: UserSerializer, current_user: @current_user
  	end

  	def show
  		@user = User.find(params[:id])
  		render json: Api::V1::UserSerializer.new(@user), current_user: @current_user
  	end

  	def sign_up
  		@user = User.new()
  		@user.name = params[:name]
  		@user.gender = params[:gender]
  		@user.height = params[:height]
  		@user.figure = params[:figure]
  		@user.work = params[:work]
  		@user.income = params[:income]
  		@user.debt = params[:debt]
  		@user.hobby = params[:hobby]
  		@user.body = params[:body]
  		@user.birthday = Time.at(params[:birthday]).to_datetime
  		@user.divorced_number = params[:divorced_number]
  		@user.children = params[:children]
  		@user.last_merried_start_time = params[:last_merried_start_time]
  		@user.last_merried_last_time = params[:last_merried_last_time]
  		@user.remarried_desired_time = params[:remarried_desired_time]
  		@user.divorced_reason = params[:divorced_reason]
  		@user.what_learned_from_divorce = params[:what_learned_from_divorce]
  		@user.adress = params[:adress]
  		@user.age = params[:age]
  		@user.final_education = params[:final_education]
  		@user.message_for_opponent = params[:message_for_opponent]
  		if params[:provider] == "facebook"
  			if @user.save
  				@user.facebook_auth.create(:access_token => params[:access_token], :user_id => @user.id)
  				@user.is_facebook_connected = true
  				@user.save?
  				render json: {
          					accsess_token: @user.authentication_token,
          					user: Api::V1::UserSerializer.new(@user)
     					 }
  			else
  				render json: {
      						error: {
        						messages: @user.errors.full_messages,
        						status: -1,
        					}
      					}
  			end
  		elsif params[:sms]
  			if @user.save
  				render json: {
          					accsess_token: @user.authentication_token,
          					user: Api::V1::UserSerializer.new(@user)
     					 }
  			else
  				render json: {
      						error: {
        						messages: @user.errors.full_messages,
        						status: -1,
        					}
      					}
  			end
  	    else
  	    	render json: {
      						error: {
        						messages: ["un supported parameter provider"],
        						status: -1,
        					}
      					}
  		end
  	end

  	def sign_in
  		if params[:provider] == "facebook"
  			@auth = FacebookAuth.find_by(accsess_token: params[:accsess_token])
  			if @auth.present?
  				@user = User.find(@auth.user_id)
  				if @user.present?
  					render json: {
          					accsess_token: @user.authentication_token,
          					user: Api::V1::UserSerializer.new(@user)
     					 }
  				else
  					render json: {
      						error: {
        						messages: ["Not found User for FacebookAuth"],
        						status: 404,
        					}
      					}
  				end
  			else
  				render json: {
      						error: {
        						messages: ["Not found FacebookAuth for accsess_token"],
        						status: 404,
        					}
      					}
  			end

  		elsif params[:sms]
  		else
  			render json: {
      						error: {
        						messages: ["un supported parameter provider"],
        						status: -1,
        					}
      					}
  		end
  	end

  	def report
  		@user = User.find(params[:id])
    	@current_user.reports.create(reportable: @user)
    	render json: {
                      	message: "sucsess report"
                      }
  	end

  	def block
  		@user_blocks = @current_user.blocks.where(blockable_type: "User")
    	if @user_blocks.find_by(blockable_id: params[:id])
        	render json: {
                  	error: {
                      	messages: ["already blocked"],
                      	status: -426
                	}
                }
    	else
      		@user = User.find(params[:id])
      		@current_user.blocks.create(blockable: @user)
      		render json: {
                      		message: "sucsess block"
                      	 }
    	end
  	end

  	def favorite
  	end

  	def update_last_login
  		@current_user.update(last_login_at: Time.now)
  		render json: {
                      	message: "sucsess update last login"
                      }
  	end

  	def search
  	end

  	def mutual_friend
  	end

  	def delete
  		if @current_user.destroy
  			ender json: {
                      	message: "sucsess destroy"
                      }
    	else
      		render json: {
                		error: {
                  			messages: @current_user.errors.full_messages,
                  			status: -1,
                	}
             }
    	end
  	end

end