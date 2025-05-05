class CustomerCombo < ApplicationRecord
  belongs_to :customer
  belongs_to :combo
  has_many :redeems, dependent: :destroy

  def remaining_quantity
    self.combo.quantity - self.redeems.count
  end
end
