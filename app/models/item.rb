class Item < ApplicationRecord
	attachment :image
	has_many :carts
	has_many :discs

	accepts_nested_attributes_for :discs
end
