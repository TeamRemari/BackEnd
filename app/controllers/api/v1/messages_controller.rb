class Api::V1::MessagesController < Api::V1::ApplicationController

	before_action :authenticate, only: [:create, :index, :show, :read]

  	protect_from_forgery :except => [:create]

  	def create
  		@to_user_id = params["to_user_id"]
      if @current_user.is_blocking_relation(@to_user_id)
        @parent_chat_room = ChatRoom.find(chat_room_id: params["parent_chat_room_id"])
        if @parent_chat_room.present?
          if @parent_chat_room.messages.count > 0
            if @current_user.is_purchased == true
                  @message = Message.new()
                  @message.user_id = @current_user.id
                  @message.to_user_id = @to_user_id
                  @message.chat_room_id = params["parent_chat_room_id"]
                  @message.type = params[:type]
                  if params[:text]
                    @message.text = params[:text]
                  end
                  if @message.save
                      render json: Api::V1::MessageSerializer.new(@message)
                  else
                      render json: {
                                error: {
                                  messages: @message.errors.full_messages,
                                  status: -1,
                                }
                              }
                  end
            else
              render json: {
                        error: {
                          messages: ["need purchase"],
                          status: -405
                        }
                    }
            end
          else
            @message = Message.new()
            @message.user_id = @current_user.id
            @message.to_user_id = @to_user_id
            @message.chat_room_id = params["parent_chat_room_id"]
            @message.type = params[:type]
            if params[:text]
              @message.text = params[:text]
            end
            if @message.save
              render json: Api::V1::MessageSerializer.new(@message)
            else
              render json: {
                        error: {
                          messages: @message.errors.full_messages,
                          status: -1,
                        }
                      }
            end
          end
        else
          render json: {
                        error: {
                          messages: ["Not found parent chat_room"],
                          status: 404
                        }
                    }
        end
      else
        render json: {
                        error: {
                          messages: ["Unauthorized. Because you are blocking relation with this user."],
                          status: 403
                        }
                    }
      end
  	end

    def index
      @messages = Message.where(chat_room_id: params["parent_chat_room_id"])
      .page(params[:page])
      .per(params[:limit])
      .order(updated_at: :desc)
      render json: @messages, each_serializer: Api::V1::MessageSerializer
    end

    def show
      @message = Message.find(params[:id])
      render json: Api::V1::MessageSerializer.new(@message)
    end

    def read

    end

end