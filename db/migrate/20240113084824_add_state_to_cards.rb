class AddStateToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :state, :integer, default: 0
  end
end
