class Product < ApplicationRecord
    monetize :price_cents
    has_many :orders, dependent: :destroy
    has_one :photo, dependent: :destroy

    accepts_nested_attributes_for :photo
end
