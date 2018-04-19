class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @reservation.listing_id = params[:id]
    @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if valid_reservation?
      if !@reservation.listing_id.nil?
        respond_to do |format|
          if @reservation.save
            ReservationMailer.booking_email(@reservation).deliver_later
            format.html { redirect_to braintree_new_path(@reservation.id), data: {turbolinks: false} }
            # format.json { render :show, status: :created, location: @post }
          else
            format.html { render :new }
            # format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_reservation_path(@reservation.listing_id), notice: @error }
      end
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :num_guests, :user_id, :listing_id)
  end

  def valid_reservation?
    return false if @reservation.start_date >= @reservation.end_date
    return false if @reservation.num_guests > Listing.find(@reservation.listing_id).max_guests
    Reservation.where(listing_id: @reservation.listing_id).each do |res|
      if @reservation.start_date > res.start_date && @reservation.start_date <= res.end_date
        @error = "Conflicting reservation on this listing"
        return false
      elsif @reservation.end_date > res.start_date && @reservation.end_date <= res.end_date
        @error = "Conflicting reservation on this listing"
        return false
      end
    end
    Reservation.where(user_id: @reservation.user_id).each do |res|
      if @reservation.start_date > res.start_date && @reservation.start_date <= res.end_date
        @error = "A reservation you already have conflicts with this one"
        return false
      elsif @reservation.end_date > res.start_date && @reservation.end_date <= res.end_date
        @error = "A reservation you already have conflicts with this one"
        return false
      end
    end
    return true
  end
end
