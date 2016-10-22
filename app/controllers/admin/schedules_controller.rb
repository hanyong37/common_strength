class Admin::SchedulesController < Admin::ApplicationController

  before_action :set_schedule, only: [:show, :update, :destroy]

  # GET /schedules
  def index
    params.permit(:store_id, :by_week)
    @schedules = Schedule.where(schedule_conditions)
    render json: @schedules
  end

  # GET /schedules/1
  def show
    render json: @schedule
  end

  # POST /schedules
  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      render json: @schedule, status: :created
    else
      render_error(@schedule,:unprocessable_entity)
    end
  end

  # PATCH/PUT /schedules/1
  def update
    if @schedule.update(schedule_params)
      render json: @schedule
    else
      render_error(@schedule,:unprocessable_entity)
    end
  end

  # DELETE /schedules/1
  def destroy
    @schedule.destroy ||  render_error(@schedule,:unprocessable_entity)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def schedule_params
    params.require(:schedule).permit(:store_id, :course_id, :capacity, :is_published, :start_time, :end_time)
  end


  def schedule_conditions
    condition = init_condition
    condition = add_store_filter_condition(condition)

    if params[:by_week].present? && params_day = Date.parse(params[:by_week])
      begin_date = Date.commercial(params_day.year, params_day.cweek, 1)
      end_date =Date.commercial(params_day.year, params_day.cweek, 7)
      qstring_clause = "And date(start_time) >= ? And date(start_time) <= ? "
      qstring_options = [ begin_date,end_date ]
      condition = add_params_condition(condition, params[:by_week], qstring_clause, qstring_options)
    end

  end
end
