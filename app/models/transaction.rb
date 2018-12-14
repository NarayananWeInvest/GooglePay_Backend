class Transaction < ApplicationRecord
  belongs_to :t_user1, :class_name => "User"
  belongs_to :t_user2, :class_name => "User"
  has_many :scratch_cards, dependent: :destroy
end
