class HistoryAddress < ApplicationRecord
  has_many :histories
  accepts_nested_attributes_for :histories
end
