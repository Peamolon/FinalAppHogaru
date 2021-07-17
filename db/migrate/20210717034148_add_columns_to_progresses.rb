class AddColumnsToProgresses < ActiveRecord::Migration[6.1]
  def change
    add_column :progresses, :burnedObjetive, :integer
    add_column :progresses, :consumedObjetive, :integer
  end
end
