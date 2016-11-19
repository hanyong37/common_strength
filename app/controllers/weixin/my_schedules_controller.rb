class Weixin::MySchedulesController < Weixin::ApplicationController
  def index
    set_schedules(Date.today)
    render json: @schedules
  end

  def show
    set_schedules(params[:id])
    render json: @schedules
  end

  private
  def set_schedules (date)
    @schedules = Schedule.viewable.by_store(@current_customer.store_id).by_date(date).time_asc
  end
end
