class Admin::TrainingsController < Admin::ApplicationController
  before_action :set_training, only: [:show, :update, :destroy]

  # GET /trainings
  def index
    @trainings = Training.joins(:schedule).where(set_conditions)
    render json: @trainings
  end

  # GET /trainings/1
  def show
    render json: @training
  end

  # POST /trainings
  def create
    @training = Training.new(training_params)

    if @training.save
      render json: @training, status: :created
    else
      render json: @training.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trainings/1
  def update
    if @training.update(training_params)
      render json: @training
    else
      render json: @training.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trainings/1
  def destroy
    @training.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_training
    @training = Training.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def training_params
    params.require(:training).permit(:customer_id, :schedule_id, :booking_status, :training_status)
  end

  def set_conditions
    condition = init_condition
    condition = add_store_filter_condition(condition)
    #condition = add_customer_filter_condition(condition)
    clause = ' AND (schedules.store_id = ?)'
    options = [ params[:store_id]]
    condition = add_params_condition(condition, params[:store_id],clause, options)

  end

end
