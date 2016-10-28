class Weixin::ApplicationController < ActionController::API
  #before_action :check_header
  before_action :validate_user
  attr_accessor :current_user

  private

  def validate_user
    token = request.headers["X-Api-Key"]
    head 403 and return unless token
    user = User.find_by token: token
    head 403 and return unless user
  end

  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api,
      serializer: ActiveModel::Serializer::ErrorSerializer
  end

  def api_error(opts = {})
    render head: :unauthorized, status: opts[:status]
  end

end
