class UsersController < ApplicationController

	before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update]

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
	end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  		flash[:success] = "Profile updated"
  		sign_in @user
		redirect_to @user
  	else
  		render 'edit'
  	end
  end

  def destroy
    User.find_by(params[:id])
    flash[:success] = "User destroyed"
    redirect_to users_url
  end

  def show
  	@user = User.find(params[:id])
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  # before filters

  def signed_in_user
  	redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


end







