class CreateLeaveApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :leave_applications do |t|
      t.datetime   :start_date
      t.datetime   :end_date
      t.string     :reason
      t.string     :status
      t.references :user,       null: false, foreign_key: true
      t.references :paid_leave, null: false, foreign_key: true

      t.timestamps
    end
  end
end
