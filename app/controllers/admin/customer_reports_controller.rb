class Admin::CustomerReportsController < Admin::ApplicationController
  def show
    cr = CustomerReport.all(params[:from_date],params[:to_date])
    render json: cr
  end
end
