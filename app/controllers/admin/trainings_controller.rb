class Admin::TrainingsController < Admin::ApplicationController
  before_action :set_training, only: [:show, :update, :destroy]

  # GET /trainings
  def index
    @trainings = paginate(Training.by_store(params[:store_id]).by_schedule(params[:schedule_id]).by_customer(params[:customer_id]))
    render json: @trainings , meta: paginate_meta(@trainings)
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

end
