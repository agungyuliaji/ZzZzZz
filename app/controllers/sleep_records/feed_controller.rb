class SleepRecords::FeedController < ApplicationController
  before_action :set_user

  def my_records
    @records = @user.sleep_records
      .order('created_at DESC')
      .page(params[:page]).per(50)
  end

  def following_records
    @records = @user.following_records
      .where('created_at >= ?', 1.week.ago)
      .order('duration DESC')
      .page(params[:page])
      .per(50)
  end

  private

  def set_user
    @user = User.find_by_id params[:user_id]
    return render json: { message: "user not found" }, status: 404 if @user.nil?
  end
end
