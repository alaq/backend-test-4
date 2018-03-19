class CreateCalls < ActiveRecord::Migration[5.1]
  def change
    create_table :calls do |t|
      t.string :caller
      t.string :status
      t.string :callid
      t.integer :call_duration
      t.integer :recording_duration
      t.string :recording_url
      t.string :selection

      t.timestamps
    end
  end
end
