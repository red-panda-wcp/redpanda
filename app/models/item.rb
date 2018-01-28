class Item < ApplicationRecord

	attachment :image
	has_many :discs, dependent: :destroy
	has_many :histories
	has_many :carts
	belongs_to :category

	attr_accessor :disc_name, :number, :song_name

 	accepts_nested_attributes_for :discs

 	validates :artist_name,:item_name,:price,:label_name,:stock, :release_date, presence: true
end
