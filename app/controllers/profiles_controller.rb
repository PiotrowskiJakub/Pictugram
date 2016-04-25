class ProfilesController < ApplicationController
  before_action :find_user

  def show
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:success] = "Your profile has been updated."
      redirect_to profile_path(@user.user_name)
    else
      @user.errors.full_messages
      flash.now[:alert] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by(user_name: params[:user_name])
  end

  def profile_params
    params.require(:user).permit(:avatar, :bio)
  end
end
