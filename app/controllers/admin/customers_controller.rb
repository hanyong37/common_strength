class Admin::CustomersController < Admin::ApplicationController
  before_action :set_customer, only: [:show, :update, :destroy]

  # GET /customers
  def index
    @customers = Customer.all

    render json: @customers
  end

  # GET /customers/1
  def show
    render json: @customer
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created
    else
      render_error(@customer, :unprocessable_entity)
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render_error(@customer, :unprocessable_entity)
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy || render_error(@customer,:unprocessable_entity)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def customer_params
    params.require(:customer).permit(:name, :mobile, :weixin, :membership_type, :membership_duedate, :membership_remaining_times, :store_id)
  end
end
