class LeaveApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @leave_applications = current_user.leave_applications
  end

  def new
    @leave_application = LeaveApplication.new
    @remaining_day = current_user.paid_leave.remaining_day
    @expiration_date = current_user.paid_leave.expiration_date
  end

  def create
    @leave_application = current_user.leave_applications.build(leave_application_params)

    if @leave_application.save
      redirect_to leave_applications_path, notice: "Leave application created successfully."
    else
      render :new
    end
  end

  private

  def leave_application_params
    params.require(:leave_application).permit(:start_date, :end_date, :reason)
  end
end
