class Order < ApplicationRecord
    monetize :price_cents
    enum status: { pending: 0, failed: 1, paid: 2, paypal_executed: 3, unpaid: 4, canceled: 5 }
    enum payment_gateway: { stripe: 0, paypal: 1 }

    belongs_to :product
    belongs_to :user


    validates :status, presence: true
    validates :user_id, presence: true, if: :purchased?
    validates :payment_gateway, presence: true, if: :purchased?
    validates :token, presence: true, if: :purchased?
    validates :charge_id, presence: true, if: :purchased?

    scope :recenty_created, -> { where(created_at: 1.minutes.ago..DateTime.now) }

    def purchased?
        [:pending, :failed, :paid, :paypal_executed].include? self.status
    end
    
end
