require 'rails_helper'

RSpec.describe Schedule, type: :model do
  before do
    @schedule = FactoryBot.build(:schedule)
  end

  describe 'スケジュール機能' do
    context 'スケジュール登録できるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@schedule).to be_valid
      end
      it 'descriptionは空でも保存できること' do
        @schedule.description = ''
        expect(@schedule).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'titleが空であれば無効であること' do
        @schedule.title = nil
        @schedule.valid?
        expect(@schedule.errors[:title]).to include("can't be blank")
      end

      it 'start_timeが空であれば無効であること' do
        @schedule.start_time = nil
        @schedule.valid?
        expect(@schedule.errors[:start_time]).to include("can't be blank")
      end
    end
  end
end