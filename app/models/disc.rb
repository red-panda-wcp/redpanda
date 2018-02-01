class Disc < ApplicationRecord
	  belongs_to :item
	  has_many :songs, dependent: :delete_all,inverse_of: :disc

	  accepts_nested_attributes_for :songs,
                                  reject_if: :all_blank,
                                  allow_destroy: true

	  # validates :disc_name, presence: true
end
