class PaidLeavesController < ApplicationController
  before_action :authenticate_user!

  def index
    @paid_leaves = PaidLeave.all
  end

  def new
    @paid_leave = PaidLeave.new
  end

  def create
    @paid_leave = current_user.paid_leave.build(paid_leave_params)

    if @paid_leave.save
      redirect_to schedules_path
    else
      render :new
    end
  end

  private

  def paid_leave_params
    params.require(:paid_leave).permit(:start_date, :end_date, :reason)
  end
end
