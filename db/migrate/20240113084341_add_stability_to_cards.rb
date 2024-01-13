class AddStabilityToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :stability, :integer, default: 0
  end
end
