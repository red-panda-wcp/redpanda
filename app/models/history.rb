class History < ApplicationRecord
  belongs_to :history_address
  belongs_to :user
  belongs_to :item

  enum order_status: { in_ordered: 0, preparation: 1, in_delivery: 2, finish: 3 }
end
