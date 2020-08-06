Rails.application.configure do
    config.stripe.secret_key = Figaro.env.STRIPE_SECRET_KEY
    config.stripe.publishable_key = Figaro.env.STRIPE_PUBLISHABLE_KEY
end