class Admin::SchedulesController < Admin::ApplicationController

  before_action :set_schedule, only: [:show, :update, :destroy]

  # GET /schedules
  def index
    @schedules = Schedule.by_store(params[:store_id]).by_course(params[:course_id]).by_week(params[:by_week])
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

end
