class CreatePaidLeaves < ActiveRecord::Migration[6.0]
  def change
    create_table :paid_leaves do |t|
      t.integer    :vacation_days,   null: false
      t.date       :expiration_date, null: false
      t.datetime   :requested_date,  null: false
      t.column     :approval_status, :approval_status_enum, null: false, default: '未申請'
      t.references :user,            null: false

      t.timestamps
    end
  end
end
