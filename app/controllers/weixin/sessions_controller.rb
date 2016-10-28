class Weixin::SessionsController < Weixin::ApplicationController
  skip_before_action :validate_user

  def create
    @current_customer = Customer.find_by_weixin(params[:openid])
    if @current_customer.blank?
     head 404 and return
    else
     render json: @current_customer, fields: {customers: [:weixin, :token]}
    end
  end
end
