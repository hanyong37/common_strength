class Admin::UsersController < Admin::ApplicationController
  #before_action :validate_type, only: [:create, :update]
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.all
    render json: users
  end


  def destroy
    if User.all.count > 1
      @user.destroy || render_error(@user, :unprocessable_entity)
    else
      @user.errors.add(:id, 'the last user can not be deleted!')
      render_error(@user, :unprocessable_entity)
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render_error(@user, :unprocessable_entity)
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @user
  end

  private
  def set_user
      @user = User.find(params[:id])|| render_error(@user, 404)
  end

  def user_params
    params.require(:user).permit(:full_name, :password, :description)
  end

end
