class CreateIsRateableRatings < ActiveRecord::Migration
  def change
    create_table :is_rateable_ratings<%=", id: :uuid" if options['id_column_type'] == 'uuid' -%> do |t|
      t.<%= options['id_column_type'] -%> :rater_id, nil: false
      t.<%= options['id_column_type'] -%> :ratee_id, nil: false
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
