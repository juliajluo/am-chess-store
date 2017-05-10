class OrdersController < ApplicationController
  include ChessStoreHelpers::Cart
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @all_orders= Order.all.chronological
    @notshipped = Order.not_shipped
  end

  def show
    # @order = @order.all
  end

  def new
    @order = Order.new
  end

  def shipping
    @unshipped_orders = Order.not_shipped
  end

  def create
    @order = Order.new(order_params)
    @order.expiration_year = @order.expiration_year.to_i
    @order.expiration_month = @order.expiration_month.to_i
    @order.user_id = current_user.id
    # @order.grand_total = calculate_cart_items_cost
    if @order.save
      save_each_item_in_cart(@order)
      @order.grand_total = calculate_cart_items_cost + @order.shipping_costs
      @order.pay
      @order.save!
      clear_cart
      redirect_to order_path(@order), notice: "Succesfully created #{@order}."
    else
      redirect_to viewcart_path
    end

  end

  def destroy
    # authorize! :destroy, @order
    @order.destroy
    redirect_to items_path, notice: "Successfully removed order from the system."
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end
  def order_params
    params.require(:order).permit(:school_id, :credit_card_number, :expiration_year, :expiration_month)
  end

end
