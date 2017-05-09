class HomeController < ApplicationController
  def home
    @items_to_reorder = Item.need_reorder.alphabetical.to_a
    @unshipped_orders = Order.not_shipped
    # @unshipped_items= OrderItem.unshipped
  end

  def about
    @unshipped_orders = Order.not_shipped

  end

  def contact
  end

  def privacy
  end

end
