class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :score
      t.string :comment
      t.integer :car_id # this is our foreign key
      t.integer :user_id
      t.timestamps
    end
  end
end
