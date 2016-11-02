class Weixin::TrainingsController < Weixin::ApplicationController
  def show
    render json: Training.find_by_id(params[:id])
  end

  def update
    @training = Training.find_by_id(params[:id])
    head 404 and return if @training.blank?
    head 403 and return unless @training.cancelable || @training.rebookable

    @training.cancel_or_rebook
    render json: @training.reload
  end

end
