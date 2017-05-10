class UsersController < ApplicationController
  include ChessStoreHelpers::Cart

  def index
    @users = User.all
  end

  def show
    # @user = User.new
  end

  def customers
    @customers = User.customers
  end

  def shippers
    @shippers = User.shippers
  end

  def managers
    @managers = User.managers
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :action =>'new'
    end
  end

  def update
    if @user.update_attribute(user_params)
      redirect_to(@current_user, :notice => 'User was successfully updated.')
    else
      render :action => 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role, :phone, :username, :password, :password_confirmation)
  end

end
