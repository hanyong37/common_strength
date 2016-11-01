class Weixin::BookingsController < Weixin::ApplicationController
  def create
    @schedule = Schedule.find_by_id params[:schedule_id]
    head 404 and return if @schedule.blank?
    head 403 and return unless Schedule.viewable.by_store(@current_customer.store_id).ids.include?(params[:schedule_id].to_i)

    so = ScheduleOperation.new(@schedule, @current_customer)

    if so.booking_status != 'not_booked'
      head 200 and return
    elsif so.bookable
      create_training('booked')
      render json: ScheduleOperation.new(@schedule, @current_customer)
    elsif so.waitable
      create_training('waiting')
      render json:  ScheduleOperation.new(@schedule, @current_customer)
    else #can't book, can't wait, means no capacity at all
      head 409 and return
    end
  end


  private

  def create_training(booking_status)
    @schedule.trainings.create(customer_id: @current_customer.id, booking_status: booking_status, training_status: 'not_start')
  end
end
