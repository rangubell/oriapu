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
    start_time = DateTime.new(
      params[:schedule][:"start_time_1i"].to_i,
      params[:schedule][:"start_time_2i"].to_i,
      params[:schedule][:"start_time_3i"].to_i,
      params[:schedule][:"start_time_4i"].to_i,
      params[:schedule][:"start_time_5i"].to_i
    )
    @schedule = Schedule.new(schedule_parameter.merge(start_time: start_time))

    if @schedule.save
      redirect_to schedules_path
    else
      render 'new'
    end
  end

  def destroy
    @schedule.destroy
    redirect_to schedules_path, notice: '削除しました'
  end

  def edit
    return if current_user == @schedule.user

    redirect_to schedules_path
  end

  def update
    start_time = DateTime.new(
      params[:schedule][:"start_time_1i"].to_i,
      params[:schedule][:"start_time_2i"].to_i,
      params[:schedule][:"start_time_3i"].to_i,
      params[:schedule][:"start_time_4i"].to_i,
      params[:schedule][:"start_time_5i"].to_i
    )

    if @schedule.update(schedule_parameter.merge(start_time: start_time))
      redirect_to schedules_path, notice: '編集しました'
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
