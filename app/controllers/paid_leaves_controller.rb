class PaidLeavesController < ApplicationController
  before_action :authenticate_user!

  def index
    @paid_leaves = PaidLeave.all
  end

  def new
    @paid_leave = PaidLeave.new
    @remaining_day = current_user.paid_leave.remaining_day
    @expiration_date = current_user.paid_leave.expiration_date
  end

  def create
    @paid_leave = PaidLeave.new(paid_leave_params)

    if @paid_leave.save
      redirect_to schedules_path
    else
      render :new
    end
  end

  private

  def paid_leave_params
    params.require(:paid_leave).permit(:add_day, :delete_day, :reason, :approval_status)
          .merge(user_id: current_user.id)
  end
end
