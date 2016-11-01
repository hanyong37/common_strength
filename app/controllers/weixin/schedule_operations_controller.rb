class Weixin::ScheduleOperationsController < Weixin::ApplicationController
  def show
    schedule = Schedule.find_by_id params[:schedule_id]
    head 404 and return if schedule.blank?
    head 403 and return unless Schedule.viewable.by_store(@current_customer.store_id).ids.include?(params[:schedule_id].to_i)
    render json: ScheduleOperation.new(schedule, @current_customer)
  end
end
