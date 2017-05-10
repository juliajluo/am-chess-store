class OrderItemsController < ApplicationController
  # def index
  #   @unshipped_orders = Order.not_shipped
  # end
  #

  #
  # def create
  #   @item_price = ItemPrice.new(item_price_params)
  #   @item_price.start_date = Date.current
  #   if @item_price.save
  #     @item = @item_price.item
  #     redirect_to item_path(@item), notice: "Changed the price of #{@item.name}."
  #   else
  #     render action: 'new'
  #   end
  # end
  #
  def ship
    @order_item = OrderItem.find(params[:order_id])
    @order_item.shipped
    @unshipped_orders = Order.not_shipped

  # private
  # def item_price_params
  #   params.require(:item_price).permit(:item_id, :price, :category)
  # end

  end

end
