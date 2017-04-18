class OrdersController < ApplicationController
  def index
    @all_orders= Order.all.chronological

  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    # @item_price.start_date = Date.current
    order.date = Date.current
    if @order.save
      redirect_to orderpath(@order), notice: "Created #{@order}."
    else
      render action: 'new'
    end
  end

  private
  def item_price_params
    params.require(:order).permit(:item_id, :price, :category)
  end

end
