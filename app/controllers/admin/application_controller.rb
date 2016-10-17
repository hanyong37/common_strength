class Admin::ApplicationController < ActionController::API
  #before_action :check_header
  attr_accessor :current_user

  private
  def check_header
    if ['POST','PUT','PATCH'].include? request.method
      if request.content_type != "application/vnd.api+json"
        head 406 and return
      end
    end
  end

  def validate_type
    if params['data'] && params['data']['type']
      if params['data']['type'] == params[:controller]
        return true
      end
    end
    head 409 and return
  end

  def validate_user
    token = request.headers["X-Api-Key"]
    head 403 and return unless token
    user = User.find_by token: token
    head 403 and return unless user
  end
  private
  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api,
      serializer: ActiveModel::Serializer::ErrorSerializer
  end
end
