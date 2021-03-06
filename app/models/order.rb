class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :postal_code, presence: true
  validates :name, presence: true
  validates :address, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, paid_up: 1, cooking: 2, preparing: 3, shipped: 4 }

  def full_address
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
