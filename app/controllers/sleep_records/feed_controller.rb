class SleepRecords::FeedController < ApplicationController
  before_action :set_user

  def my_records
  end

  def following_records
  end

  private

  def set_user
    @user = User.find_by_id params[:user_id]
    return render json: { message: "user not found" }, status: 404 if @user.nil?
  end
end
