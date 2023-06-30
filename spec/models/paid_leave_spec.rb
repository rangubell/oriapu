require 'rails_helper'

RSpec.describe PaidLeave, type: :model do
  before do
    @paid_leave = FactoryBot.build(:paid_leave)
  end

  describe 'バリデーション' do
    it 'total_dayが0以上であれば有効であること' do
      @paid_leave.total_day = 1
      expect(@paid_leave).to be_valid
    end

    it 'remaining_dayが0以上であれば有効であること' do
      @paid_leave.remaining_day = 1
      expect(@paid_leave).to be_valid
    end

    it 'total_dayが負の値であれば無効であること' do
      @paid_leave.total_day = -1
      @paid_leave.valid?
      expect(@paid_leave.errors[:total_day]).to include('must be greater than or equal to 0')
    end

    it 'remaining_dayが負の値であれば無効であること' do
      @paid_leave.remaining_day = -1
      @paid_leave.valid?
      expect(@paid_leave.errors[:remaining_day]).to include('must be greater than or equal to 0')
    end
  end

  describe 'メソッドの挙動' do
    it 'granted_dateが現在の日付よりも過去の場合、有給を追加すること' do
      paid_leave = FactoryBot.create(:paid_leave, granted_date: Date.yesterday, remaining_day: 0)
      expect {
        PaidLeave.grant_annual_leave_if_due
      }.to change { paid_leave.reload.remaining_day }
    end
    it 'granted_dateが現在の日付よりも未来の場合、有給を追加しないこと' do
      paid_leave = FactoryBot.create(:paid_leave, granted_date: Date.tomorrow, remaining_day: 0)
      expect {
        PaidLeave.grant_annual_leave_if_due
      }.not_to change { paid_leave.reload.remaining_day }
    end
  end
end 