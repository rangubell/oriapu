require 'rails_helper'

RSpec.describe LeaveApplication, type: :model do
  before do
    @leave_application = FactoryBot.build(:leave_application)
  end

  describe 'バリデーション' do
    it '有効な属性であること' do
      expect(@leave_application).to be_valid
    end

    it 'start_dateが存在しない場合は無効であること' do
      @leave_application.start_date = nil
      expect(@leave_application).to be_invalid
      expect(@leave_application.errors[:start_date]).to include("can't be blank")
    end

    it 'end_dateが存在しない場合は無効であること' do
      @leave_application.end_date = nil
      expect(@leave_application).to be_invalid
      expect(@leave_application.errors[:end_date]).to include("can't be blank")
    end

    it 'reasonが存在しない場合は無効であること' do
      @leave_application.reason = nil
      expect(@leave_application).to be_invalid
      expect(@leave_application.errors[:reason]).to include("can't be blank")
    end

    it 'statusが存在しない場合は無効であること' do
      @leave_application.status = nil
      expect(@leave_application).to be_invalid
      expect(@leave_application.errors[:status]).to include("can't be blank")
    end
  end

  describe 'メソッド' do
    it 'end_dateがstart_dateよりも前の場合は無効であること' do
      @leave_application.start_date = Date.today
      @leave_application.end_date = Date.yesterday
      expect(@leave_application).to be_invalid
      expect(@leave_application.errors[:end_date]).to include('must be after start date')
    end
    it '有給申請のステータスが「承認」の場合、trueを返すこと' do
      @leave_application.status = '承認'
      expect(@leave_application.status_approved?).to be true
    end
    it '有給申請のステータスが「承認」以外の場合、falseを返すこと' do
      @leave_application.status = '保留'
      expect(@leave_application.status_approved?).to be false
    end
  end
end
