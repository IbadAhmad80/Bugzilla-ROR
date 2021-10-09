class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.references :bug, null: false, foreign_key: true
      t.timestamps
    end
    add_index :comments, [:bug_id, :created_at]
  end
end
