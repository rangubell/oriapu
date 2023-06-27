class CreateLeaveApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :leave_applications do |t|
      t.datetime   :start_date,       null: false
      t.datetime   :end_date,         null: false
      t.string     :reason,           null: false, default: "有給消失日のため"
      t.string     :status,           default: "保留"
      t.references :user,             null: false, foreign_key: true
      t.references :paid_leave,       null: false, foreign_key: true
      t.integer    :updated_by_user_id

      t.timestamps
    end
  end
end
