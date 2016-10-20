class Admin::CustomersController < Admin::ApplicationController
  before_action :set_customer, only: [:show, :update, :destroy]

  # GET /customers
  def index
    params.permit(:store_id, :qstring)
    @customers = Customer.where(customer_conditions)
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
    params.require(:customer).permit(:name, :mobile, :weixin, :membership_type, :membership_duedate, :membership_remaining_times, :store_id, :is_locked)
  end

  def customer_conditions

    condition = init_condition
    condition = add_store_filter_condition(condition)

    qstring_clause = ' AND (weixin like ? OR mobile like ? OR name like ? )'
    qstring_options = [ "%#{params[:qstring]}%", "%#{params[:qstring]}%", "%#{params[:qstring]}%"]

    condition = add_params_condition(condition, params[:qstring], qstring_clause, qstring_options)

  end
end
