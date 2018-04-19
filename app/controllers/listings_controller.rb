class ListingsController < ApplicationController
  before_action :check_user, except: [:index, :show]
  # before_action :file_upload, only: [:new, :create, :update]

  # GET /listings
  def index
    @listings = Listing.where(nil)
    if params[:search_location].present?
      @listings = @listings.location_tag(params[:search_location][:location_tag])
    elsif params[:filter].present?
      @listings = @listings.baths(params[:filter][:baths]) if params[:filter][:baths].present?
      @listings = @listings.bedrooms(params[:filter][:bedrooms]) if params[:filter][:bedrooms].present?
      @listings = @listings.max_price(params[:filter][:max_price]) if params[:filter][:max_price].present?
    end
    @listings = @listings.paginate(:page => params[:page], :per_page => 10).order(:verified)
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/:id
  def show
  end

  # PATCH/PUT /listings/:id
  def update
  end

  def verify
    if current_user.role == "superadmin" || current_user.role == "moderator"
      listing = Listing.find(params[:id])
      listing.verified? ? listing.verified = 'false' : listing.verified = 'true'
      listing.save
    end
    redirect_to listings_path
  end

  def create
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to listings_path, :flash => { :success => "Listing created successfully!" } }
      else
        format.html { redirect_to new_listing_path, :flash => { :error => "Error creating listing" } }
      end
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    listing_id = @listing.id
    u_id = @listing.user_id
    respond_to do |format|
      if @listing.destroy
        Reservation.where(listing_id: listing_id).destroy_all
        format.html { redirect_to user_path(u_id), :flash => { :success => "Listing successfully removed" } }
      else
        format.html { redirect_to user_path(u_id), :flash => { :error => "Listing wasn't successfully removed" } }
      end
    end
  end

  private

    def listing_params
      params[:listing][:user_id] = current_user.id
      params[:listing][:tags] = params[:listing][:tags].split(" ") unless params[:listing][:tags].blank?
      params.require(:listing).permit(:address, :max_guests, :bedrooms, :amenities, :user_id, :baths, :rate_in_usd, :tags => [])
    end

    def check_user
      if !current_user
        redirect_to root_path
      end
    end

    # def file_upload
    #   if !params[:listing][:avatar].nil?
    #     uploader = AvatarUploader.new
    #     puts params[:listing][:avatar].original_filename
    #     uploader.store!(params[:listing][:avatar].original_filename)
    #   end
    # end

end
