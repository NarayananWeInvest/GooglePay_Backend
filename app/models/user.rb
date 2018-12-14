class User < ApplicationRecord
	has_many :bank_accounts, dependent: :destroy
	has_many :t_user1, :class_name => "Transaction", :foreign_key => "t_user1_id"
	has_many :t_user2, :class_name => "Transaction", :foreign_key => "t_user2_id"
end
