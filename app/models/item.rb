class Item < ApplicationRecord
    has_one_attached :item_image

    has_many :cart_items, dependent: :destroy
    has_many :order_details, dependent: :destroy
    belongs_to :genre

    def get_item_image(width, height)
        item_image.variant(resize_to_limit: [width, height]).processed
    end

    def with_tax_price
        (price * 1.1).floor
    end

end
