class CreatePaidLeaves < ActiveRecord::Migration[6.0]
  def change
    create_table :paid_leaves do |t|
      t.date       :use_date
      t.integer    :vacation_days,   default: 0
      t.integer    :remaining_days,  default: 0
      t.date       :expiration_date
      t.datetime   :start_date 
      t.datetime   :end_date 
      t.string     :reason,          default: '法定付与日のため'
      t.string     :status,          default: '保留'
      t.references :user,            null: false, foreign_key: true

      t.timestamps
    end
  end
end
