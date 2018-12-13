class Api::V1::ApplicationController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  serialization_scope :view_context
	before_action :authenticate
  attr_reader :current_user

	protected

  # Authenticate the user with token based authentication
  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
      authenticate_with_http_token do |token, options|
      @current_user = User.find_by(authentication_token: token)
    end
  end

  def render_unauthorized(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render json: 'Bad credentials', status: :unauthorized
  end

  ActionController::Parameters.action_on_unpermitted_parameters = :raise
  
  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: { error: { unknown_parameters: pme.params } }, 
           status: :bad_request
  end

  def response_parameter_missing_for(params_symbol)
    render json: {
      error: {
        messages: [ "Parameter is missing for #{params_symbol}" ],
        status: -1,
        }
      }
      return
  end

end