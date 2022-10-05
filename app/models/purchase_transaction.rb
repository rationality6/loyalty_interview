class PurchaseTransaction < ApplicationRecord
  belongs_to :user
  has_one :point_history
end
