class CreateNodesNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes_nodes do |t|

      t.timestamps
    end
  end
end
