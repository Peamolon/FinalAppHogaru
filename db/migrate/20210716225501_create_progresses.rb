class CreateProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :progresses do |t|
      t.date :expires_at
      t.integer :consumedCalories
      t.integer :burnedCalories
      t.integer :user_id
      t.integer :porcent

      t.timestamps
    end
  end
end
