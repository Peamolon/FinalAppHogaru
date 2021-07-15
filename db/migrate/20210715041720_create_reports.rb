class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :consumedCalories
      t.integer :burnedCalories
      t.integer :diference
      t.string :diference_value
      t.date :creation_date

      t.timestamps
    end
  end
end
