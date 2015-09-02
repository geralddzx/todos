class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
			t.string :name, null: false
			t.boolean :complete, null: false, default: false
			t.string :setting
			t.datetime :time
		  t.timestamps null: false
    end
  end
end
