class History < ApplicationRecord
  belongs_to :history_address
  belongs_to :user
  belongs_to :item

  enum order_status: { preparation: 0, in_delivery: 1, finish: 2 }
end
