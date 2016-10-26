class Admin::SessionsController < Admin::ApplicationController
  skip_before_action :validate_user, only:[:create]
  def create
    @user = User.find_by(full_name: create_params[:full_name])
    if @user && @user.authenticate(create_params[:password])
      self.current_user = @user
      render json: current_user, serializer: SessionSerializer
    else
      return api_error(status: 401)
    end
  end

  def destroy
    token = request.headers["X-Api-Key"]
    head 403 and return unless token
    user = User.find_by token: token
    head 403 and return unless user
    user.regenerate_token
    head 204 and return
  end

  private
  def create_params
    params.require(:user).permit(:full_name,:password)
  end

end
