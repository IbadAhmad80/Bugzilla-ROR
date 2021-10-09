class CreateBugs < ActiveRecord::Migration[6.1]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.string :priority
      t.integer :estimated_time
      t.integer :developer_id
      t.integer :qa_id
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bugs, [:user_id, :created_at]
  end
end
