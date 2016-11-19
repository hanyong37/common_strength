class Weixin::BookingsController < Weixin::ApplicationController
  def create
    @schedule = Schedule.find_by_id params[:schedule_id]
    head 404 and return if @schedule.blank?
    head 403 and return unless Schedule.viewable.by_store(@current_customer.store_id).ids.include?(params[:schedule_id].to_i)

    so = ScheduleOperation.new(@schedule, @current_customer)

    if so.is_membership_valid
      if so.bookable
        create_training('booked')
        render json: ScheduleOperation.new(@schedule, @current_customer)
      elsif so.waitable
        create_training('waiting')
        render json:  ScheduleOperation.new(@schedule, @current_customer)
      else
        render json: so, status: :conflict
      end
    else
      render json: so, status: :conflict
    end

  end


  private

  def create_training(booking_status)
    @schedule.trainings.create(customer_id: @current_customer.id, booking_status: booking_status, training_status: 'normal')
  end
end
