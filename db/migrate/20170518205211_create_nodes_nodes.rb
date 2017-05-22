class CreateNodesNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes_nodes do |t|
      t.string :name, null: false
      t.string :title, null: false
      t.string :file, null: false
      t.string :hash, null: false
      t.references :user, null: false
      t.date :date, null: false
      t.timestamps
    end
  end
end
