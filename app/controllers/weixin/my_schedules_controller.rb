class Weixin::MySchedulesController < Weixin::ApplicationController
  def index
    get_schedules(Date.today)
    render json: @schedules
  end

  def show
    get_schedules(params[:id])
    render json: @schedules
  end

  private
  def get_schedules (date)
    @schedules = Schedule.viewable.by_store(@current_customer.store_id).by_date(date).time_asc
  end
end
