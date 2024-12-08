class SocialController < ApplicationController
  before_action :set_user

  def follow
    handle_response @user.follow(@target_user)
  end

  def unfollow
    handle_response @user.unfollow(@target_user)
  end

  private

  def set_user
    @user = User.find_by_id params[:user_id]
    return render json: { message: "user not found" }, status: 404 if @user.nil?

    @target_user = User.find_by_id params[:target_user_id]
    return render json: { message: "target user not found" }, status: 404 if @target_user.nil?
  end

  def handle_response(operation_state)
    if operation_state
      render json: { message: "ok" }, status: 200
    else
      render json: { message: "failed" }, status: 400
    end
  end
end
