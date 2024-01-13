class AddRepToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :reps, :integer, default: 0
  end
end
