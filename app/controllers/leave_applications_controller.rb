class LeaveApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_leave_application, only: [:show]

  def index
    @leave_applications = LeaveApplication.where(status: '保留')
    @department_id = current_user.department_id
  end  

  def new
    @leave_application = LeaveApplication.new
    @remaining_day = current_user.paid_leave.remaining_day
  end

  def create
    @leave_application = LeaveApplication.new(leave_application_params)
    @leave_application.user = current_user

    if @leave_application.save
      redirect_to schedules_path, notice: '有給申請が作成されました。'
    else
      render :new
    end
  end

  def update_status
    @leave_application = LeaveApplication.find(params[:id])
    @leave_application.status = params[:leave_application][:status]
    @leave_application.updated_by_user = current_user
  
    if @leave_application.status == '承認'
      @leave_application.consume_leave_days
    end
  
    if @leave_application.save
      redirect_to leave_applications_path, notice: "申請のステータスを更新しました"
    else
      redirect_to schedules_path
    end
  end
  

  def show
    @approved_leave_applications = LeaveApplication.where(status: ['承認', '却下'], user_id: current_user.id)
    @updated_by_user = @leave_application.updated_by_user
  end

  private

  def leave_application_params
    params.require(:leave_application).permit(:start_date, :end_date, :reason)
          .merge(user_id: current_user.id, paid_leave_id: current_user.paid_leave.id)
  end  

  def set_leave_application
    @leave_application = LeaveApplication.find_by(id: params[:id])
  end  
end