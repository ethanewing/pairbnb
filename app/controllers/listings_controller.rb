class ListingsController < ApplicationController

  # GET /listings
  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to listings_path, notice: 'Listing was successfully created.' }
        # format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        # format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def listing_params
      p params
      params.require(:listing).permit(:address, :max_guests, :bedrooms, :amenities)
    end

end
