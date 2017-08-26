class CreateNodesNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :nodes_nodes do |t|
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
