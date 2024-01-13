class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.text :front
      t.text :back
      t.references :user, null: false, foreign_key: true
      t.references :deck, null: false, foreign_key: true
      t.integer :rating
      t.datetime :next_review

      t.timestamps
    end
  end
end
