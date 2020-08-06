class Orders::Stripe
    ## TODO: Use Payments API instead of Charges API for bank requests and card authentication
    # https://stripe.com/docs/payments/accept-a-payment-charges
    INVALID_STRIPE_OPERATION = 'Invalid Stripe Operation'

    def self.execute(order:, user:)
        product = order.product

        if product.stripe_plan_name.blank?
            charge = self.execute_charge(
                price_cents: product.price_cents,
                description: product.name,
                card_token: order.token
            )
        else
            # Subscriptions
        end

        order.charge_id = charge.id
        
    rescue Stripe::StripeError => e
        order.error_message = INVALID_STRIPE_OPERATION
        order.failed!
    end

    private

    def self.execute_charge(price_cents:, description:, card_token:)
        if Rails.env.development? || Rails.env.test?
            card_token = 'tok_visa'
        end
        Stripe::Charge.create({
            amount: price_cents.to_s,
            currency: "usd",
            description: description,
            source: card_token
        })
    end

end
