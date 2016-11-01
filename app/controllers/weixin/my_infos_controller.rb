class Weixin::MyInfosController < Weixin::ApplicationController
  def show
    render json: @current_customer
  end
end
