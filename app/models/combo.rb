class Combo < ApplicationRecord
  belongs_to :service
  has_many :customer_combos, dependent: :destroy
  has_many :customers, through: :customer_combos
  has_many :redeems, dependent: :destroy

  validates :quantity, numericality: { greater_than: 0 }

  validates :discount, numericality: { greater_than_or_equal_to: 0 }

  before_save :calculate_total_price

  def calculate_total_price
    base_total = service.price * quantity
    self.total_price = base_total - discount
  end
end
