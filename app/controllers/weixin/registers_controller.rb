class Weixin::RegistersController < Weixin::ApplicationController
  skip_before_action :validate_user

  def create
    head 400 and return unless params[:mobile].present?
    head 400 and return unless params[:openid].present?
    @current_customer = Customer.find_by_mobile(params[:mobile])
    head 404 and return if @current_customer.blank?
    #head 409 and return unless @current_customer.weixin.blank?
    #如果用户换微信，直接覆盖之前的weixinid:
    @current_customer.weixin = params[:openid]
    @current_customer.save
    render json: @current_customer, fields: {customers: [:weixin, :token]}
  end
end
