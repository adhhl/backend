class AddDuesPredictToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :dues_predict, :string
  end
end
