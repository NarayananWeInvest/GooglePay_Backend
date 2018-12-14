class CreateScratchCards < ActiveRecord::Migration[5.2]
  def change
    create_table :scratch_cards do |t|
      t.bigint :user_id
      t.string :amount_won
      t.belongs_to :trans_id, index: true
      
      t.timestamps
    end
  end
end
