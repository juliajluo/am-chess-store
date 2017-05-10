class OrdersController < ApplicationController
  include ChessStoreHelpers::Cart

  def index
    @all_orders= Order.all.chronological
    @notshipped = Order.not_shipped
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
      @order.grand_total = calculate_cart_items_cost + @order.shipping
      @order.pay
      @order.save!
      clear_cart
      redirect_to home_path, notice: "Succesfully created #{@order}."
    else
      redirect_to viewcart_path
    end

  end

  private
  def order_params
    params.require(:order).permit(:school_id, :credit_card_number, :expiration_year, :expiration_month)
  end

end
