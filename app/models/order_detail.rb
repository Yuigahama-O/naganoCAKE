class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def subtotal
    price * amount
  end

  enum making_status: { impossible_making: 0, waiting_making: 1, making: 2, finish_making: 3 }
end
