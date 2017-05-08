class CartController < ApplicationController
  include ChessStoreHelpers::Cart

  def viewcart
    @order_items = get_list_of_items_in_cart
  end

  def add_to_cart
    #need to figure out logic for adding to cart

    add_item_to_cart(params[:id])
    #need to figure out where the user goes next
    redirect_to :back #many options for this
  end

  def remove_item

    remove_item_from_cart(params[:id])
    redirect_to :back
  end

  def clear
    clear_cart
    redirect_to :back
  end

  def checkout
    redirect_to new_order_path
  end

  def checkout_form
    # calculate_cart_items_cost
    # @order =Order.new
    # # @order.save!
    # if @order.save
    #   save_each_item_in_cart(@order)
    #   redirect_to :back, notice: "Successfully created order."
    #   redirect_to home_path
    # else
    #   redirect_to viewcart_path
    # end
  end






end
