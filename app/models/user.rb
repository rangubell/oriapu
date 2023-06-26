class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :department
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
  validates :department_id, numericality: { other_than: 1 , message: "can't be blank"}

  has_many :schedules
  has_many :leave_applications
  has_one :paid_leave

  after_create :create_paid_leave

  private

  def create_paid_leave
    build_paid_leave(vacation_days: 0, remaining_days: 0).save
  end
end
