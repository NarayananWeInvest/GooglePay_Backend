class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :t_user1
      t.references :t_user2
      t.string :amount
      
      t.timestamps
    end
  end
end
