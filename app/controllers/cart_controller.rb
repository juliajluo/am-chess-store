class CartController < ApplicationController
  include ChessStoreHelpers::Cart

  def viewcart

  end

  def add_to_cart
    #need to figure out logic for adding to cart
    add_item_to_cart(params[:id])
    #need to figure out where the user goes next
    redirect_to :back #many options for this
  end





end
