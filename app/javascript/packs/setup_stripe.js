$(document).ready(function() {
    setupStripeCard();
});

function setupStripeCard() {
    // TODO: Use Figaro if possible.
    var stripe = Stripe("#{ENV['STRIPE_PUBLISHABLE_KEY']}");
    var elements = stripe.elements();
    var card = elements.create('card');
    card.mount("#card-element");

    card.addEventListener('change', function(e) {
        var displayError = document.getElementById('card-errors');
        if (event.error) {
            displayError.textContent = event.error.message;
        } else {
            displayError.textContent = '';
        }
    });
    setupStripeToken();
};

function setupStripeToken() {
    $('#payment-form').on('click', function(e) {
        e.preventDefault();

        stripe.createToken(card).then(function(result) {
            if (result.error) {
                var errorElement = docuemnt.getElementById('card-errors');
                errorElement.textContent = result.error.message;
            } else {
                var form = document.getElementById('payment-form');
                form.append('<input type="hidden" name=orders[token]"/>').val(token.id)

                form.submit();
            }
        });
    });
};
