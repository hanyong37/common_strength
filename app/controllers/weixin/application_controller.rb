class Weixin::ApplicationController < ActionController::API
  before_action :validate_user
  attr_accessor :current_customer

  private

  def paginate_meta(resource)
    {
      current_page: resource.current_page,
      next_page: resource.next_page,
      prev_page: resource.prev_page,
      total_pages: resource.total_pages,
      total_count: resource.total_count
    }
  end

  def paginate(resource)
    resource = resource.page(params[:page] || 1)
    if params[:per_page]
      resource = resource.per(params[:per_page])
    end
    return resource
  end

  def validate_user
    token = request.headers["X-Api-Key"]
    head 403 and return unless token
    @current_customer = Customer.find_by token: token
    head 403 and return unless @current_customer
  end

  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api,
      serializer: ActiveModel::Serializer::ErrorSerializer
  end

  def api_error(opts = {})
    render head: :unauthorized, status: opts[:status]
  end

end
