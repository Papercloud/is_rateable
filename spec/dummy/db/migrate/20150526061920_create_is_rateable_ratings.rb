class CreateIsRateableRatings < ActiveRecord::Migration
  def change
    create_table :is_rateable_ratings do |t|
      t.integer :rater_id, nil: false
      t.integer :ratee_id, nil: false
      t.string :rater_type
      t.string :ratee_type
      t.integer :score, nil: false, default: 0
      t.timestamps
    end
    add_index :is_rateable_ratings, :rater_id
    add_index :is_rateable_ratings, :ratee_id
    add_index :is_rateable_ratings, :score
  end
end
