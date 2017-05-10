class OrderItemsController < ApplicationController

  def ship
    @order_item = OrderItem.find(params[:order_id])
    @order_item.shipped
    @unshipped_orders = Order.not_shipped


  end

end
