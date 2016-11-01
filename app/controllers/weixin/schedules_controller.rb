class Weixin::SchedulesController < Weixin::ApplicationController
  def show
    head 404 and return if Schedule.find_by_id(params[:id]).blank?
    head 403 and return unless Schedule.viewable.by_store(@current_customer.store_id).ids.include?(params[:id].to_i)
    render json: Schedule.find_by_id(params[:id])
  end
end
