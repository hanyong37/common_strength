class Weixin::MyTrainingsController < Weixin::ApplicationController
  def show
    return 400 unless (Training.booking_statuses.keys+Training.training_statuses.keys+%w/all/).include? params[:id]
    @trainings = paginate(eval('@current_customer.trainings.time_desc.'+ params[:id]))
    render json: @trainings, meta: paginate_meta(@trainings)
  end
end
