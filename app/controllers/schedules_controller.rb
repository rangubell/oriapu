class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_schedule, only: [:edit, :show, :destroy, :update]

  def index
    @schedules = current_user.schedules
  end

  def new
    @schedule = Schedule.new
  end

  def show
  end
  

  def create
    Schedule.create(schedule_parameter)
    redirect_to schedules_path
  end
  

  def destroy
    @schedule.destroy
    redirect_to schedules_path, notice:"削除しました"
  end

  def edit
    unless current_user == @schedule.user
      redirect_to schedules_path
    end
  end
  

  def update
    if @schedule.update(schedule_parameter)
      redirect_to schedules_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_parameter
    params.require(:schedule).permit(:title, :description, :start_time).merge(user_id: current_user.id)
  end

end