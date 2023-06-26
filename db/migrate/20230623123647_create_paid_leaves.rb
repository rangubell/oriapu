class CreatePaidLeaves < ActiveRecord::Migration[6.0]
  def change
    create_table :paid_leaves do |t|
      t.date       :use_date
      t.integer    :vacation_days,   default: 0
      t.integer    :remaining_days,  default: 0
      t.date       :expiration_date
      t.references :user,            null: false, foreign_key: true

      t.timestamps
    end
  end
end
