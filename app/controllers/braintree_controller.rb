class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    reservation = Reservation.find(params[:checkout_form][:reservation_id])
    listing = Listing.find(reservation.listing_id)
    amount = listing.rate_in_usd.to_i * ((reservation.end_date - reservation.start_date)/1.day)
    p amount

    result = Braintree::Transaction.sale(
     :amount => amount,
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      redirect_to :root, :flash => { :success => "Transaction successful!" }
    else
      reservation.destroy
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end
end
