class Admin::CustomersController < Admin::ApplicationController
  before_action :set_customer, only: [:show, :update, :destroy]

  # GET /customers
  def index
    # TODO: change condition to scope;
    params.permit(:store_id, :qstring)
    @customers = paginate(Customer.where(set_conditions).by_locked(to_bool(params[:locked])))
    render json: @customers ,fields: {customers: [:id,
                                                  :name,
                                                  :mobile,
                                                  :is_weixin_connected,
                                                  :membership_type,
                                                  :store_id,
                                                  :membership_remaining_times,
                                                  :membership_total_times,
                                                  :membership_duedate,
                                                  :store_name,
                                                  :is_locked,
                                                  :show_status]}, meta: paginate_meta(@customers)
  end

  # GET /customers/1
  def show
    render json: @customer,fields: {customers: [:id,
                                                :name,
                                                :mobile,
                                                :is_weixin_connected,
                                                :membership_type,
                                                :store_id,
                                                :membership_remaining_times,
                                                :membership_total_times,
                                                :membership_duedate,
                                                :store_name,
                                                :show_status,
                                                :is_locked]}
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
    params.permit(:operation_memo)
    #if @customer.update(customer_params) && params[:operation_memo].presence?
    if @customer.update(customer_params)
      create_operation(@customer)
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
    params.require(:customer).permit(:name, :mobile, :weixin, :membership_type, :membership_duedate, :membership_total_times, :store_id, :is_locked)
  end

  def set_conditions

    condition = init_condition
    condition = add_store_filter_condition(condition)

    qstring_clause = ' AND (weixin like ? OR mobile like ? OR name like ? )'
    qstring_options = [ "%#{params[:qstring]}%", "%#{params[:qstring]}%", "%#{params[:qstring]}%"]

    condition = add_params_condition(condition, params[:qstring], qstring_clause, qstring_options)

  end

  def create_operation(customer)
    operation = Operation.new(user_id: current_user.id,
                              customer_id: customer.id,
                              target: 'customer',
                              description: "系统用户: '#{current_user.full_name}'修改了客户:'#{customer.name}', 会员类型： '#{customer.membership_type}', 会员到期时间:'#{customer.membership_duedate}', 会员卡次数:'#{customer.membership_total_times}' ",
                             operation_memo: params[:operation_memo])
    operation.save!
  end

  def to_bool(str)
    return true if str == 'true'
    return false if str == 'false'
    return nil
  end
end
