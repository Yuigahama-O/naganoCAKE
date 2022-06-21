class Delivery < ApplicationRecord
  
  belongs_to :customer, dependent: :destroy

  def full_address
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end
