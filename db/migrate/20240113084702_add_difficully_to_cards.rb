class AddDifficullyToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :difficulty, :integer, default: 0
  end
end
