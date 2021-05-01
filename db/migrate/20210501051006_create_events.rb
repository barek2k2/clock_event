class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :event_type
      t.datetime :event_at
      t.string :location_ip
      t.text :user_agent

      t.timestamps
    end
    add_index :events, :user_id
  end
end
