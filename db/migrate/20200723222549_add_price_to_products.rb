class AddPriceToProducts < ActiveRecord::Migration[6.0]
  def change
    add_monetize :products, :price, currency: { present: true }
  end
end
