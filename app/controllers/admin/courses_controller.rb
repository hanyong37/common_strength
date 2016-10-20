class Admin::CoursesController < Admin::ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]

  # GET /courses
  def index
    @courses = Course.all

    render json: @courses
  end

  # GET /courses/1
  def show
    render json: @course
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course, status: :created
    else
      render_error(@course,:unprocessable_entity)
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      render json: @course
    else
      render_error(@course,:unprocessable_entity)
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy ||  render_error(@course,:unprocessable_entity)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
    params.require(:course).permit(:name, :type_id, :store_id, :status, :description, :default_capacity)
    end
end
