class ChangeActivitiesDateColumnType < ActiveRecord::Migration
  def up
    change_column(:activities, :date,:integer)
  end

  def down
  end
end
