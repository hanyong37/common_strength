class Weixin::MyTrainingsController < Weixin::ApplicationController
  def show
    return 400 unless (Training.booking_statuses.keys+Training.training_statuses.keys+%w/all/).include? params[:id]
    render json: eval('@current_customer.trainings.'+ params[:id])
  end
end
