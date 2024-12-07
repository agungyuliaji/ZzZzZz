class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.datetime :clock_in_time
      t.datetime :clock_out_time

      t.timestamps
    end
  end
end
