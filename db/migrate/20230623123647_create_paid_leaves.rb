class CreatePaidLeaves < ActiveRecord::Migration[6.0]
  def change
    create_table :paid_leaves do |t|
      t.integer    :total_day,   default: 0
      t.integer    :remaining_day,  default: 0
      t.date       :granted_date
      t.references :user,            null: false, foreign_key: true

      t.timestamps
    end
  end
end
