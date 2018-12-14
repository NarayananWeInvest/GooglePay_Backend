class CreateBankAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_accounts do |t|
      t.string :acc_no, :null => false
      t.string :ifsc, :null => false
      t.string :balance, :default => 0
      
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
