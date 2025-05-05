class Service < ApplicationRecord
  has_many :combos, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
end
