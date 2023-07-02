class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :department

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
  validates :department_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :hired_date, presence: true

  has_many :schedules
  has_many :leave_applications
  has_one :paid_leave, dependent: :destroy # 追加

  after_create :create_paid_leave

  private

  def create_paid_leave
    build_paid_leave(
      total_day: 0,
      remaining_day: 0,
      granted_date: hired_date + 6.months
    ).save
  end
end
