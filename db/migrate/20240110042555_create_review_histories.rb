class CreateReviewHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :review_histories do |t|
      t.references :card, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
