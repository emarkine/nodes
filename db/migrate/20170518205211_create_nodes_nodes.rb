class CreateNodesNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes_nodes do |t|
      t.string :hash
      t.string :name
      t.string :title
      t.date :date
      t.timestamps
    end
  end
end
