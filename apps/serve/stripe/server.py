'''
This is a python flask server using stripe to create a payment intent
'''


from flask import Flask, jsonify, request
import stripe  # pip install stripe

app = Flask(__name__)

stripe.api_key = 'your_stripe_secret_key'


@app.route('/create-payment-intent', methods=['POST'])
def create_payment():
    try:
        data = request.json
        intent = stripe.PaymentIntent.create(
            amount=data['cents'],
            currency='usd',
            payment_method_types=['card'],
        )
        return jsonify({'clientSecret': intent['client_secret']})
    except Exception as e:
        return jsonify(error=str(e)), 403


if __name__ == 'main':
    app.run(port=4242)
