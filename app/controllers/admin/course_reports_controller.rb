class Admin::CourseReportsController < Admin::ApplicationController
  def show
    cr = CourseReport.all(params[:from_date],params[:to_date])
    render json: cr
  end
end
