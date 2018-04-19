class UsersController < ApplicationController
  # before_action :file_upload, only: [:new, :create, :update]
  before_action :file_upload, only: [:update]
  before_action :confirm_user, only: [:update]

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(avatar: params[:user][:avatar], username: params[:user][:username], first_name: params[:user][:first_name], last_name: params[:user][:last_name])
    respond_to do |format|
      format.html { redirect_to edit_user_path(@user) }
      format.js
    end
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end

  private

  def file_upload
    if !params[:user][:avatar].blank?
      uploader = AvatarUploader.new
      uploader.store!(params[:user][:avatar].original_filename)
    end
  end

  def confirm_user
    if current_user.id != params[:id].to_i
      redirect_to root_path
    end
  end

end
