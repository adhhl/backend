class AddLastReviewToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :last_review, :datetime
  end
end
