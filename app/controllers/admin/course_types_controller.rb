class Admin::CourseTypesController < Admin::ApplicationController
  before_action :set_course_type, only: [:show, :update, :destroy]

  # GET /course_types
  def index
    @course_types = CourseType.all

    render json: @course_types
  end

  # GET /course_types/1
  def show
    render json: @course_type
  end

  # POST /course_types
  def create
    @course_type = CourseType.new(course_type_params)

    if @course_type.save
      render json: @course_type, status: :created, location: @course_type
    else
      render json: @course_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /course_types/1
  def update
    if @course_type.update(course_type_params)
      render json: @course_type
    else
      render json: @course_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /course_types/1
  def destroy
    @course_type.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course_type
    @course_type = CourseType.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def course_type_params
    params.require(:course_type).permit(:name, :description)
  end
end
