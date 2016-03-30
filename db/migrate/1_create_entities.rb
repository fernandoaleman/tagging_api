class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :entity_type, null: false
      t.string :entity_id, null: false

      t.timestamps null: false
    end

    add_index :entities, :entity_type
    add_index :entities, :entity_id
  end
end
