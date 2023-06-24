class CreatePaidLeaves < ActiveRecord::Migration[6.0]
  def change
    create_table :paid_leaves do |t|
      t.integer    :add_day
      t.integer    :delete_day
      t.string     :reason,          default: '法定付与日のため'
      t.string     :approval_status, default: '保留'
      t.references :user,            null: false

      t.timestamps
    end
  end
end
