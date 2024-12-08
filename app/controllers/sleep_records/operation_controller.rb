class SleepRecords::OperationController < ApplicationController
  before_action :find_user

  def sleep
    handle_response(@user.sleep!)
  end

  def wake_up
    handle_response(@user.wake_up!)
  end

  def reset
    handle_response(@user.reset!)
  end

  private

  def find_user
    @user = User.find_by_id params[:user_id]
    render json: { message: "user not found" }, status: 404 if @user.nil?
  end

  def handle_response(operation_state)
    if operation_state
      render json: { message: "ok", data: @user }, status: 200
    else
      render json: { message: "failed", errors: @user.errors }, status: 400
    end
  end
end
