class Admin::OperationsController < Admin::ApplicationController
  before_action :set_operation, only: [:show, :update, :destroy]

  # GET /operations
  def index

    params.permit(:customer_id)
    @operations = Operation.where(set_conditions)

    render json: @operations
  end

  # GET /operations/1
  def show
    render json: @operation
  end

  #  # POST /operations
  #  def create
  #    @operation = Operation.new(operation_params)
  #
  #    if @operation.save
  #      render json: @operation, status: :created
  #    else
  #      render json: @operation.errors, status: :unprocessable_entity
  #    end
  #  end

  # PATCH/PUT /operations/1
  #  def update
  #    if @operation.update(operation_params)
  #      render json: @operation
  #    else
  #      render json: @operation.errors, status: :unprocessable_entity
  #    end
  #  end

  # DELETE /operations/1
  def destroy
    @operation.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_operation
    @operation = Operation.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  #def operation_params
  #  params.require(:operation).permit(:user_id, :description)
  #end

  def set_conditions

    condition = init_condition
    condition = add_customer_filter_condition(condition)
    condition = add_user_filter_condition(condition)

  end
end
