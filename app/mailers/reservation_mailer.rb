class ReservationMailer < ApplicationMailer
  default from: "notifications@pairbnb.com"

  def booking_email(reservation)
    @reservation = reservation
    @listing = Listing.find(@reservation.listing_id)
    @host = User.find(@listing.user_id)
    @customer = User.find(@reservation.user_id)
    @url = user_url(@host, host: "pairbnb.com")
    mail(to: @host.email, subject: "New Reservation!")
  end
end
