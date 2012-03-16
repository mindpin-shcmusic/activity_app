class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.text   :content
      t.string  :date
      t.integer :creator_id
      t.timestamps
    end
  end
end
